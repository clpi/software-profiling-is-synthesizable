# The model: software profiling is synthesizable

This is the model Chris dictated on 2026-11-18, in his terms. It is a
proposal for the qualification of software, on its measurement side: an
incrementally provable proof system for eliminating redundant compute,
suboptimal ordering, and suboptimal venue use across all synthesized
automata, with economic calculation and measurement over time, and a
visibility vector over the measured software. The plan it grounds must
be executable, achievable, and measurable; the plan is the last section
of this file.

Four states are kept distinct throughout, here and in the README:
settled intent, proposed semantics, proven, and open. Nothing is
stated in a stronger state than its evidence.

## Settled intent

The following is settled intent, dictated 2026-11-18.

1. There is no baseline for any execution, and none is needed.
   No arbitrary baseline is posited in the system being measured.
   Constructed runtime measures are established only where a part
   of the system overlaps the system in question.
2. The proof system is incrementally provable. Any arbitrary
   workload, bounded only by environmental information, can prove
   facts about any arbitrary runtime or job, as empirically
   verified. The analysis is itself empirically verified, by
   empirical falsification: a constructed measure stands only
   with its certified witness states, and a falsifying witness
   kills it.
3. The witness states are not merely small. They are
   incrementally provably independent, vanishingly small, and
   combinatorially sufficient, and from them an exponentially
   compounding set of constructed measures is provable.
   Independence is the point.
4. Venue and ordering are not fixed variables. They are
   parametric with what is being measured and with the
   qualification contract at play. A venue is a discrete range,
   a discrete set of environmental configurations, parametrically
   attuned and solved for. The qualification problem space is
   finite as a necessary consequence of the contract: to qualify
   is to pick out named software, named criteria, and the
   behavior intended under them, over finite discrete sets.
   Finiteness is derived from that, never assumed.
5. Where ordering affects sequential runtimes that affect one
   another through side effects, those effects are accounted for
   deterministically and incrementally, modeled as idempotent,
   and solved for over discretely, finitely bound variables.
   Economic calculation and time are inside this accounting.
6. Computation proven to have no base value, or redundant, or
   suboptimally ordered, sequenced, or distributed, is
   eliminable. Eliminating it preserves every constructed
   measure.
7. The model carries a visibility vector for stakeholders: each
   stakeholder class sees a projection of the certified state.

## Proven

The Lean development in the folder named proof formalizes the
provable core. Each theorem below is proved in full under the
family gate: zero sorries, no premises of its own, printed axioms
a subset of the standard set. The names are the theorem names in
the source.

- baseline. Baseline independence. The constructed measure is a
  function of the overlap and the certified witnesses alone, so
  it is invariant under any choice of external baseline. The
  baseline place is present in the statement of the measured
  value and absent from its value; the theorem is that any two
  baselines give the same measure.
- finiteness. Finiteness derived from the contract. A contract
  is a venue list and an ordering list, each finite and
  discrete. The configuration count is the product of the two
  counts. Finiteness is a computed conclusion about the
  contract's own sets, not a hypothesis about a larger space.
- compounding. Witness compounding, exact form. The assignments
  of truth values to k witness positions number exactly 2 to
  the k, by doubling at each added independent witness.
- distinctness. The assignments counted by compounding are
  pairwise distinct, so the exponential count counts distinct
  constructed measures, one per assignment, not repetitions.
- incremental. Incremental accounting equals full accounting.
  Accounting a sequence of effects in two stages, carrying the
  state across the seam, equals accounting the whole sequence
  from the start. Incremental is the design; there is no batch
  mode underneath that this is an approximation of.
- idempotence. An idempotent effect applied twice in a row
  contributes exactly what it contributes once, at any position
  the fold has reached.
- elimination. Redundancy elimination soundness. A step that is
  inert on every state, a computation with no base value, may
  be removed at any position in a sequence, and every accounted
  measure of the sequence is preserved.
- optimum. Over any nonempty finite list of costs, a least
  element exists.
- solved. The solved configuration. Under any cost assignment,
  a contract with a nonempty configuration set has a
  configuration of least cost over the whole set. The optimum
  is solved for by the finite search the proof performs; it is
  decidable over the finite set, never assumed.
- falsification. Empirical falsification. If a falsifying
  witness is in the certified set of a measure, the measure
  does not stand. Standing is defined as every certified
  witness holding, so one falsifying witness kills it.
- controlone and controltwo. Adversarial controls. A baseline
  dependent variant provably fails baseline independence, and
  a non idempotent effect provably fails reapplication
  invariance. The conditions are load bearing.

## Premise

One premise is carried, labeled as a premise and stated as a rule
of the model, settled as intent: facts about a runtime or a job
enter the system only as certified witness states. The Lean
development itself carries no premise: every theorem above is
proved from the definitions in the file, with no axioms beyond
the standard set the gate allows.

## Proposed semantics

- The bridge from an empirical profiling campaign to the proof
  system: a campaign's run facts are read as certified witness
  states, and the campaign's claim that its witness facts are
  pairwise independent is what places them in the compounding
  construction, where each witness doubles the assignment set
  independently of the others. The construction is proven; the
  reading of a concrete campaign into it is proposed semantics,
  to be discharged campaign by campaign.
- The visibility vector: the projection of the certified state
  that each stakeholder class sees. Named here as a spec
  provision. No formalization is claimed; see the open list.

## Open

- The visibility vector has no formalization yet. The
  obstruction: no projection form has been chosen that is
  provably a function of the certified state alone, stakeholder
  class by stakeholder class. It stands as a spec provision,
  proposed, until that form is chosen and proved.
- The economic calculation over time is proven at one cost
  assignment (optimum, solved). A cost assignment that varies
  over time, re solved at each step with verdicts carried by
  the incremental accounting, is not yet formalized. The
  incremental theorem covers accounting of effects; the
  re solving over a sequence of cost assignments is open.
- Independence of empirical witness facts is a per campaign
  discharge under the proposed bridge above. The proof system
  proves compounding from independence inside the construction;
  it does not prove that a given campaign's facts are
  independent. That is the campaign's evidence to bring.

## The plan

Executable, achievable, measurable. Each step names its measure.

1. Name the contract. Write the venue list and the ordering
   list for the qualification at play. Measure: the
   configuration count, computed as the product of the two
   list counts, per the finiteness theorem.
2. Certify the witnesses. Run the workload and record each
   fact as a certified witness state, each with its evidence.
   Measure: the witness count k, and the independence
   discharge for each pair, per the proposed bridge.
3. Construct the measures on the overlaps. For each part of
   the system that overlaps the system in question, construct
   its measures from the witness assignments. Measure: the
   assignment count, 2 to the k, all distinct, per the
   compounding and distinctness theorems. No baseline is
   posited at any point in this step.
4. Account the ordering effects. Fold the effects of the
   sequential runtimes in sequence order, incrementally, with
   effects modeled as idempotent. Measure: the accounted
   value, with the incremental theorem guaranteeing it equals
   the full accounting, and the idempotence theorem
   guaranteeing reapplication changes nothing.
5. Eliminate. Remove every step the accounting proves inert,
   and re account. Measure: steps removed, and the accounted
   value unchanged, per the elimination theorem; the economic
   calculation is the accounted cost over time before and
   after, over the same contract.
6. Solve for the configuration. Search the finite
   configuration set under the contract's cost assignment.
   Measure: the least cost found and the configuration that
   attains it, whose existence the solved theorem proves.
7. Falsify continuously. Keep measuring over time. Any new
   witness that falsifies a standing measure removes that
   measure, per the falsification theorem. Measure: the
   standing set, and its changes, each change traced to the
   falsifying witness that caused it.
8. Publish the visibility vector. Project the certified state
   per stakeholder class. Measure: the projection itself,
   once its form is chosen; this step is proposed until the
   open item above it closes.

## Completion pass, 2026-11-18

A second landing the same day, closing the gaps the first
landing named or left implicit. The definitions of every term
of the model now stand in the file named defs, at the
resolution an implementer needs, each tied to its Lean
counterpart. The Lean development gained six theorems and one
control, all proved in full under the same gate:

- complete. Combinatorial sufficiency: every truth assignment
  of length k occurs among the assignments of k witness
  positions. The witness set realizes every combination, not
  merely the count of them.
- free. Freedom of a witness position: any value at a
  position, with any assignment of the rest, is a combined
  state. Independence read at one coordinate.
- carried. Standing carries: standing under a certified set
  implies standing under any subset of it, so verdicts are
  carried by the witnesses that were load bearing for them.
- relabeled. Invariance under relabeling: a comparison of
  two measured values is unchanged by any strictly
  increasing relabeling. No absolute origin enters a
  verdict; this is the no baseline condition at full
  strength, beyond its definitional form in the baseline
  theorem.
- parametric. Parametric verdicts: the order of two
  configurations flips between two cost assignments, so a
  verdict exists only relative to the contract at play.
- swap. Swapping commuting effects: two sequential effects
  that commute may be exchanged in the sequence with the
  accounting unchanged.
- controlthree. The dependence control: a locked family of
  two witness positions forced to agree has two combined
  states, fewer than the compounded count of four, and
  every state in it has its positions equal. Independence
  is load bearing for the compounding count, by concrete
  counterexample, kept in the tree as a standing control
  beside the first two controls.

The premise census is unchanged: one carried premise, that
facts about a runtime or a job enter the system only as
certified witness states. The open list is unchanged: the
visibility vector has no formalization yet, and the economic
calculation over a sequence of cost assignments varying over
time is not yet formalized.
