# Definitions

The definitions of the measurement model, at the resolution an
implementer needs: each term states what it is, how it is
recognized or built, and its counterpart in the Lean development
in the folder named proof. The model itself is stated in the
file named spec. States follow the family discipline: a
definition here is settled intent as dictated; its formal
counterpart is proven where a theorem is named, and is a named
premise or an open item where the spec says so.

## Workload

A workload is the named task whose execution is to be measured:
a program, a job suite, or a single run, picked out by name in
the qualification at play. A workload is an input to the model,
never constructed by it. In the Lean development a workload
enters only through the facts certified about its runs, so no
Lean type names it directly; that absence is the environmental
boundedness of the model, stated as settled intent in the spec.

## Runtime, or job

A runtime, or job, is one execution of a workload: the thing a
constructed measure is about. Two runs of the same workload are
two jobs. As with the workload, a job enters the Lean
development only through its certified witness states and its
measured values at the overlaps.

## Environmental information

Environmental information is everything about the setting of a
run that the qualification contract names: the venue, the
ordering, the machine state the contract counts as relevant.
It is the only bound on what a proof in this system may use
about a job: facts about a job enter as certified witness
states recorded under environmental information, and nothing
else about the job is available to the construction. This is
the model's one carried premise, labeled in the spec.

## Venue

A venue is one environmental configuration: one element of the
discrete set of configurations the contract names. A venue is
not a machine name; it is the full configuration the contract
counts as one setting, machine included where the contract
says so. In the Lean development a venue is an element of the
venue list of a contract. A venue is solved for: the solved
theorem selects a configuration of least cost over the whole
configuration set, so no venue is privileged in advance.

## Ordering

An ordering is one sequence in which the steps of a job may be
accounted: one element of the discrete set of orderings the
contract names. In the Lean development an ordering is an
element of the ordering list of a contract, and a sequence of
effects is accounted in ordering sequence by the account fold.
Where two effects commute, the swap theorem shows the two
orders account the same, so the choice between them is free.

## Qualification contract

The qualification contract is the parameter source of the
whole model: the named software, the named criteria, and the
behavior intended under them, for one qualification at play.
In the Lean development it is the structure with two fields,
the venue list and the ordering list, each finite and
discrete. Its configuration set is the grid of the two lists.
Finiteness of the problem space is derived from this
definition: to qualify is to pick out named finite sets, so
the configuration count is a computed product of two list
counts, per the finiteness theorem. It is never a hypothesis
about a larger space. The parametric theorem shows the
contract is a genuine parameter: the order of two
configurations flips between two cost assignments, so no
verdict exists apart from a contract.

## Witness state

A witness state is one certified fact about a job: a single
recorded outcome, with its evidence, stated so it can hold or
fail. In the Lean development a witness state is one truth
value in an assignment, and a certified set of witnesses is a
list of truth values. A witness state is certified by the
campaign that produced it; the proof system takes the
certification as its premise and reasons from the states
themselves.

## Independence

Witness states are independent when no state's value is
forced by the others: at each position, either value occurs
with assignments of the rest held fixed. Independence is the
property the compounding count rests on. In the Lean
development it is built into the assignment construction,
where each added position doubles the set, and it is proved
in three forms: completeness (every assignment of the right
length occurs), freedom (any value at a position, with any
assignment of the rest, is a combined state), and the third
control (lock two positions together and the count collapses
below the compounded count, so the property is load bearing).

## Constructed measure

A constructed measure is a value derived from certified
witness states at an overlap, and from nothing else. In the
Lean development the derived function takes an overlap value
and a witness count and returns their sum; the theorems are
about the form, not the arithmetic: the value is invariant
under any choice of external baseline (the baseline theorem),
and any comparison of two constructed measures is invariant
under strictly increasing relabeling of the values (the
relabeled theorem), so no absolute origin enters a verdict.

## Overlap

An overlap is a part of the system that is also part of the
system in question: the shared part where a measure can be
established. A constructed measure is established only at an
overlap. Where there is no overlap, the model constructs
nothing and claims nothing; that silence is by design, since
a measure without a shared part would need a baseline or a
bridge the model refuses to posit.

## Side effect

A side effect is the change one step of a sequential runtime
works on the accounted state, where a later step reads what
an earlier step wrote. In the Lean development a side effect
is a function from states to states, and a sequence of them
is accounted by the account fold in sequence order. The
accounting is deterministic because the fold is a function,
and incremental because accounting in two stages equals
accounting the whole, per the incremental theorem.

## Idempotence

An effect is idempotent when applying it twice in a row
changes nothing beyond applying it once, at every state. The
model requires ordering effects to be modeled as idempotent
so that reapplication is free: the idempotence theorem proves
a doubled idempotent step accounts exactly what the single
step accounts. The second control proves the condition is
load bearing: the successor effect is not idempotent, and
its doubled accounting differs from its single accounting.

## Standing

A constructed measure stands when every certified witness
state in its set holds. Standing is the verdict the proof
system maintains over time. It is falsifiable by construction:
one falsifying witness in the set kills it, per the
falsification theorem. It also carries: standing under a set
implies standing under any subset, per the carried theorem,
so verdicts survive the removal of witnesses that were not
load bearing for them.

## No base value, and elimination

A step has no base value when it is inert: it maps every
state to itself, contributing nothing to any accounted
measure. Such a step is eliminable at any position in a
sequence, and the elimination theorem proves every accounted
measure of the sequence is preserved by its removal.
Redundancy in this model is the wider notion the spec
states; the Lean theorem covers the inert case in full, and
the spec marks the wider reading at its own state.

## Cost assignment

A cost assignment is the contract's pricing of configurations:
a value for each configuration, under which the configuration
set is searched. In the Lean development it is a function
from configurations to natural values, and the solved theorem
proves a least cost configuration exists under any cost
assignment over a nonempty configuration set. That the cost
assignment tracks real economic cost and real time for a
given campaign is that campaign's evidence to bring; the
spec carries the time varying case as open.

## Visibility vector

The visibility vector is, for each stakeholder class, the
projection of the certified state that class sees. It is a
spec provision, proposed: no projection form has been chosen
that is provably a function of the certified state alone, and
the spec carries it as open until that form is chosen and
proved. Nothing in the Lean development claims it.
