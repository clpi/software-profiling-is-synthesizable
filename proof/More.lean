/-
  Completion pass, 2026-11-18: the theorems and the control
  that close the gaps the first landing named or left
  implicit. Combinatorial sufficiency of the witness set,
  freedom of each witness position, carrying of standing
  under a subset of witnesses, invariance of comparisons
  under relabeling, parametric verdicts, swapping of
  commuting effects, and the dependence control: when two
  witness positions are locked together, the compounding
  count collapses, so independence is load bearing.
-/

import Profiling

namespace Profiling

/-- Combinatorial sufficiency: every truth assignment of
    length k occurs among the assignments of k witness
    positions. The witness set does not merely count the
    combinations; it realizes every one of them. -/
theorem complete (k : Nat) : ∀ x : List Bool, x.length = k → x ∈ assignments k := by
  induction k with
  | zero =>
    intro x hx
    cases x with
    | nil => exact List.Mem.head _
    | cons b rest =>
      have h1 : (b :: rest).length = rest.length + 1 := rfl
      omega
  | succ k ih =>
    intro x hx
    cases x with
    | nil =>
      have h1 : ([] : List Bool).length = 0 := rfl
      omega
    | cons b rest =>
      have h1 : (b :: rest).length = rest.length + 1 := rfl
      have hr : rest.length = k := by omega
      have hmem := ih rest hr
      cases b with
      | false =>
        show (false :: rest) ∈ (assignments k).map (fun a => false :: a)
          ++ (assignments k).map (fun a => true :: a)
        exact List.mem_append.mpr (Or.inl (List.mem_map.mpr ⟨rest, hmem, rfl⟩))
      | true =>
        show (true :: rest) ∈ (assignments k).map (fun a => false :: a)
          ++ (assignments k).map (fun a => true :: a)
        exact List.mem_append.mpr (Or.inr (List.mem_map.mpr ⟨rest, hmem, rfl⟩))

/-- Freedom of a witness position: any value at the head
    position, with any assignment of the remaining
    positions, is a combined state. No position is
    constrained by the others; that is independence read
    at one coordinate, and completeness gives it at every
    coordinate. -/
theorem free (k : Nat) (b : Bool) (rest : List Bool) (h : rest.length = k) :
    (b :: rest) ∈ assignments (k + 1) :=
  complete (k + 1) (b :: rest) (by rw [List.length_cons, h])

/-- Standing carries: a measure that stands under a set of
    certified witnesses stands under any subset of them.
    Verdicts reached from fewer witnesses are carried, not
    recomputed; the proof system is incremental in this
    direction as well. -/
theorem carried (big small : List Bool) (h : ∀ w ∈ small, w ∈ big) :
    stands big → stands small := by
  intro hbig w hw
  exact hbig w (h w hw)

/-- Invariance under relabeling: a comparison of two
    measured values is unchanged when every value is
    carried through a strictly increasing relabeling. No
    absolute origin and no fixed scale enters a verdict;
    only the relative order of the two values at the
    overlap decides it. This is the no baseline condition
    read as invariance, beyond the definitional form. -/
theorem relabeled (φ : Nat → Nat) (h : ∀ x y : Nat, x < y → φ x < φ y)
    (a b : Nat) : (φ a < φ b ↔ a < b) := by
  constructor
  · intro hlt
    rcases (by omega : b = a ∨ b < a ∨ a < b) with h1 | h1 | h1
    · rw [h1] at hlt
      exact absurd hlt (Nat.lt_irrefl _)
    · have h2 := h b a h1
      omega
    · exact h1
  · intro hlt
    exact h a b hlt

/-- Parametric verdicts: the order of two configurations
    is not intrinsic to the configurations. Under one cost
    assignment the first is cheaper; under another, the
    second is. A verdict exists only relative to the
    contract at play, which supplies the cost assignment;
    there is no contract free ordering to appeal to. -/
theorem parametric :
    ∃ x y : Nat × Nat, ∃ first second : Nat × Nat → Nat,
      first x < first y ∧ second y < second x :=
  ⟨(0, 0), (1, 0), fun p => p.1, fun p => 1 - p.1, by decide, by decide⟩

/-- Swapping commuting effects: two sequential effects
    that commute may be exchanged in the sequence, and
    the accounting is unchanged. Ordering is a parameter
    to be solved for; where two orders account the same,
    the choice between them is free. -/
theorem swap (e f : Nat → Nat) (h : ∀ s, e (f s) = f (e s))
    (rest : List (Nat → Nat)) (s : Nat) :
    account (e :: f :: rest) s = account (f :: e :: rest) s := by
  show account rest (f (e s)) = account rest (e (f s))
  rw [h s]

/-- The locked family: two witness positions forced to
    agree. Only two combined states survive the lock. -/
def locked : List (List Bool) := [[false, false], [true, true]]

/-- Control three: dependence collapses the count. The
    locked family has fewer combined states than the
    compounding count for two positions, and every state
    in it has its two positions equal. The exponential
    count of the compounding theorem is therefore not a
    formality: remove independence and it fails, by this
    concrete counterexample, kept in the tree as a
    standing control. -/
theorem controlthree :
    locked.length < (assignments 2).length
      ∧ ∀ x ∈ locked, x[0]? = x[1]? := by
  constructor
  · have h1 : locked.length = 2 := rfl
    have h2 := compounding 2
    have h3 : (2 : Nat) ^ 2 = 4 := rfl
    omega
  · intro x hx
    have hx2 : x ∈ [[false, false], [true, true]] := hx
    cases hx2 with
    | head => rfl
    | tail _ rest =>
      cases rest with
      | head => rfl
      | tail _ more => cases more

end Profiling

#print axioms Profiling.complete
#print axioms Profiling.free
#print axioms Profiling.carried
#print axioms Profiling.relabeled
#print axioms Profiling.parametric
#print axioms Profiling.swap
#print axioms Profiling.controlthree
