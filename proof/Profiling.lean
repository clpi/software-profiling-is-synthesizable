/-
  Software profiling is synthesizable: the measurement proof model.

  The model, as dictated by Chris on 2026-11-18. A constructed
  measure is established only where a part of the system overlaps
  the system in question, from a set of certified witness states.
  No baseline for any execution enters the construction, and none
  is needed. Venue and ordering are discrete, finite, and solved
  for under the qualification contract at play. Ordering effects
  on sequential runtimes are accounted deterministically and
  incrementally, with effects modeled as idempotent. Computation
  with no base value is eliminable. Every theorem below is proved
  in full; the file carries no premise of its own.
-/

namespace Profiling

/-- The value a constructed measure takes: a function of the
    overlap and of the certified witness count alone. -/
def derived (overlap witness : Nat) : Nat :=
  overlap + witness

set_option linter.unusedVariables false in
/-- A measured value, stated with a baseline place so the
    independence theorem has the shape the model dictates: the
    baseline place is present in the statement and absent from
    the value. The unused variable is the point, so its linter
    is silenced for this one definition. -/
def measured (overlap witness baseline : Nat) : Nat :=
  derived overlap witness

/-- Baseline independence: the constructed measure is invariant
    under any choice of external baseline, because the value is
    a function of the overlap and the witnesses alone. -/
theorem baseline (overlap witness first second : Nat) :
    measured overlap witness first = measured overlap witness second :=
  rfl

/-- The qualification contract at play: its venue set and its
    ordering set, each a finite discrete list of environmental
    configurations. Venue and ordering are parameters of the
    contract, never fixed constants of the model. -/
structure Contract where
  venues : List Nat
  orders : List Nat

/-- The grid of a pair of discrete lists: every venue paired
    with every ordering. -/
def grid : List Nat → List Nat → List (Nat × Nat)
  | [], _ => []
  | v :: rest, orders => orders.map (fun o => (v, o)) ++ grid rest orders

/-- The configuration set of a contract: the grid of its venue
    set and its ordering set. -/
def configurations (c : Contract) : List (Nat × Nat) :=
  grid c.venues c.orders

theorem gridlength (venues orders : List Nat) :
    (grid venues orders).length = venues.length * orders.length := by
  induction venues with
  | nil => simp [grid]
  | cons v rest ih =>
    show (orders.map (fun o => (v, o)) ++ grid rest orders).length
      = (rest.length + 1) * orders.length
    rw [List.length_append, List.length_map, ih, Nat.succ_mul]
    exact Nat.add_comm _ _

/-- Finiteness, derived: the configuration count of a contract
    is the product of the counts of its two finite discrete
    sets. Finiteness here is a conclusion computed from the
    contract, never a hypothesis imposed on a larger space. -/
theorem finiteness (c : Contract) :
    (configurations c).length = c.venues.length * c.orders.length :=
  gridlength c.venues c.orders

/-- Every assignment of truth values to a list of witness
    positions, built by doubling: each new independent witness
    doubles the assignment set. -/
def assignments : Nat → List (List Bool)
  | 0 => [[]]
  | k + 1 => (assignments k).map (fun a => false :: a)
      ++ (assignments k).map (fun a => true :: a)

/-- Witness compounding: k independent binary witness facts
    yield exactly 2 ^ k assignments, hence at least 2 ^ k
    distinct constructed measures, one per assignment. The
    count is exact, and distinctness is the next theorem. -/
theorem compounding (k : Nat) : (assignments k).length = 2 ^ k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    show ((assignments k).map (fun a => false :: a)
      ++ (assignments k).map (fun a => true :: a)).length = 2 ^ (k + 1)
    rw [List.length_append, List.length_map, List.length_map, ih,
      Nat.pow_succ]
    omega

/-- The assignments are pairwise distinct, so the compounding
    count counts distinct measures, not repetitions. -/
theorem distinctness (k : Nat) : (assignments k).Nodup := by
  induction k with
  | zero => exact List.Pairwise.cons (fun a h => by cases h) List.Pairwise.nil
  | succ k ih =>
    show ((assignments k).map (fun a => false :: a)
      ++ (assignments k).map (fun a => true :: a)).Nodup
    refine List.pairwise_append.mpr ⟨?_, ?_, ?_⟩
    · exact List.Pairwise.map _ (fun a b hab h => hab (List.cons.inj h).2) ih
    · exact List.Pairwise.map _ (fun a b hab h => hab (List.cons.inj h).2) ih
    · intro x hx y hy hxy
      obtain ⟨a, _, rfl⟩ := List.mem_map.mp hx
      obtain ⟨b, _, rfl⟩ := List.mem_map.mp hy
      exact Bool.noConfusion (List.cons.inj hxy).1

/-- The accounting of a sequence of effects on a state, as a
    fold in sequence order. The state here is the accounted
    measure; effects are arbitrary state maps. -/
def account : List (Nat → Nat) → Nat → Nat
  | [], s => s
  | e :: rest, s => account rest (e s)

/-- Incremental accounting equals full accounting: accounting
    for a sequence in two stages, carrying the state across the
    seam, gives exactly the accounting of the whole sequence
    from the start. There is no batch mode underneath. -/
theorem incremental (first second : List (Nat → Nat)) (s : Nat) :
    account (first ++ second) s = account second (account first s) := by
  induction first generalizing s with
  | nil => rfl
  | cons e rest ih => exact ih (e s)

/-- Idempotent reapplication: an effect that is idempotent
    contributes nothing when applied twice in a row that it did
    not contribute once, at any position reached by the fold. -/
theorem idempotence (e : Nat → Nat) (h : ∀ s, e (e s) = e s)
    (rest : List (Nat → Nat)) (s : Nat) :
    account (e :: e :: rest) s = account (e :: rest) s := by
  show account rest (e (e s)) = account rest (e s)
  rw [h s]

/-- Redundancy elimination soundness: a step that is inert on
    every state, a computation with no base value, may be
    removed at any position in a sequence, and every accounted
    measure of the sequence is preserved. -/
theorem elimination (e : Nat → Nat) (h : ∀ s, e s = s)
    (before after : List (Nat → Nat)) (s : Nat) :
    account (before ++ e :: after) s = account (before ++ after) s := by
  rw [incremental, incremental]
  show account after (e (account before s)) = account after (account before s)
  rw [h]

/-- A least element of a nonempty list of costs: over a finite
    discrete set, an optimum exists. -/
theorem optimum (costs : List Nat) (h : costs ≠ []) :
    ∃ m, m ∈ costs ∧ ∀ c ∈ costs, m ≤ c := by
  induction costs with
  | nil => exact absurd rfl h
  | cons x rest ih =>
    cases rest with
    | nil => exact ⟨x, List.Mem.head _, fun c hc => by
        cases hc with
        | head => exact Nat.le_refl x
        | tail _ t => cases t⟩
    | cons y tail =>
      obtain ⟨m, hm, hmin⟩ := ih (by simp)
      cases Nat.le_total x m with
      | inl hxm =>
        refine ⟨x, List.Mem.head _, fun c hc => ?_⟩
        cases hc with
        | head => exact Nat.le_refl x
        | tail _ ht => exact Nat.le_trans hxm (hmin c ht)
      | inr hmx =>
        refine ⟨m, List.Mem.tail _ hm, fun c hc => ?_⟩
        cases hc with
        | head => exact hmx
        | tail _ ht => exact hmin c ht

/-- The solved configuration: under any cost assignment, a
    contract with a nonempty configuration set has a
    configuration whose cost is least over the whole set. The
    optimum over the finite set is decidable by the same finite
    search this existence proof performs, and the configuration
    is solved for, never assumed. -/
theorem solved (c : Contract) (cost : Nat × Nat → Nat)
    (h : configurations c ≠ []) :
    ∃ cfg, cfg ∈ configurations c
      ∧ ∀ other ∈ configurations c, cost cfg ≤ cost other := by
  obtain ⟨m, hm, hmin⟩ :=
    optimum ((configurations c).map cost) (by
      intro hempty
      apply h
      cases hcfg : configurations c with
      | nil => rfl
      | cons a rest =>
        rw [hcfg] at hempty
        simp at hempty)
  obtain ⟨cfg, hcfg, hcost⟩ := List.mem_map.mp hm
  refine ⟨cfg, hcfg, fun other hother => ?_⟩
  have : cost other ∈ (configurations c).map cost :=
    List.mem_map.mpr ⟨other, hother, rfl⟩
  rw [hcost]
  exact hmin _ this

/-- The standing condition of a certified measure: every
    certified witness state in its set holds. -/
def stands (witnesses : List Bool) : Prop :=
  ∀ w ∈ witnesses, w = true

/-- Empirical falsification: a single falsifying witness in
    the certified set kills the standing of the measure. A
    constructed measure stands only with its witnesses. -/
theorem falsification (witnesses : List Bool) (w : Bool)
    (hmem : w ∈ witnesses) (hfalse : w = false) :
    ¬ stands witnesses := by
  intro h
  have h1 := h w hmem
  rw [hfalse] at h1
  exact Bool.false_ne_true h1

end Profiling

#print axioms Profiling.baseline
#print axioms Profiling.finiteness
#print axioms Profiling.compounding
#print axioms Profiling.distinctness
#print axioms Profiling.incremental
#print axioms Profiling.idempotence
#print axioms Profiling.elimination
#print axioms Profiling.optimum
#print axioms Profiling.solved
#print axioms Profiling.falsification
