# Software profiling is synthesizable

## The claim

Software profiling is synthesizable: there is an incrementally provable
proof system in which constructed runtime measures are established
from a vanishingly small set of certified witness states, with no
baseline for any execution, and in which venue and ordering are
discrete, finite, and solved for under the qualification contract at
play. Redundant compute, suboptimal ordering, and suboptimal venue
use are eliminable inside the system, with economic calculation and
measurement over time, and a visibility vector over the measured
software.

The full model, in the terms it was dictated in, is in the file
named spec: the settled intent, what is proven, what is premise,
what is proposed, what is open, and the executable, achievable,
measurable plan the model grounds.

## The parts and their evidence states

Evidence states use the four states of this family: settled intent,
proposed, implemented, and verified. Nothing in this file claims a
part is verified before its artifact and check land in this
repository. States below are as of the landing, 2026-11-18.

- The claim: settled intent. This is the ruling of Chris, dictated
  on the voice call of 2026-11-18.
- The model: settled intent, written in full in the file named
  spec, including the plan.
- The Lean proof of the provable core: proven, and landed in the
  folder named proof. The theorems, each proved in full, are:
  baseline (baseline independence: the constructed measure is a
  function of the overlap and the certified witnesses alone,
  invariant under any choice of external baseline); finiteness
  (the configuration count of a contract is the product of its
  two finite discrete set counts, so finiteness is derived from
  the contract, never assumed); compounding (k independent
  binary witness facts yield exactly 2 to the k assignments);
  distinctness (those assignments are pairwise distinct, so the
  count counts distinct constructed measures); incremental
  (incremental accounting of effects equals the full accounting
  of the whole sequence); idempotence (an idempotent effect
  applied twice contributes what it contributes once);
  elimination (removing a step that is inert on every state, a
  computation with no base value, preserves every accounted
  measure); optimum (a least element exists over any nonempty
  finite cost list); solved (a contract with a nonempty
  configuration set has a least cost configuration under any
  cost assignment, decidable by finite search); falsification
  (one falsifying witness in the certified set kills the
  standing of a measure). The folder also carries two
  adversarial controls, controlone and controltwo, proving the
  baseline and idempotence conditions are load bearing. The
  check gate in that folder passes cold with zero sorries; the
  printed axioms are propext and Quot.sound, both standard.
- The premise: one premise is carried, labeled in the spec as a
  rule of the model: facts about a runtime or a job enter the
  system only as certified witness states. The Lean development
  carries no premise of its own.
- Proposed: the bridge that reads a concrete profiling
  campaign's run facts as certified witness states, and the
  visibility vector, the projection of the certified state each
  stakeholder class sees. Both are stated in the spec as
  proposed semantics; neither is claimed proven.
- Open, named in full in the spec: the visibility vector has no
  formalization yet (no projection form chosen that is provably
  a function of the certified state alone); the economic
  calculation over time is proven at one cost assignment, and
  re solving over a sequence of cost assignments with carried
  verdicts is not yet formalized; the independence of a given
  campaign's witness facts is that campaign's evidence to
  bring, discharged per campaign under the proposed bridge.

## Running the check

The gate is the shell script in the folder named proof. Run it
with a Lean 4.19.0 binary on the path, or named in the LEAN
environment variable. It compiles every Lean file in that folder
with warnings as errors, rejects every proof escape token, and
audits the printed axioms against the standard set.

## The sources of record

- The dictation of Chris on the voice call of 2026-11-18, held
  in the Idol workspace records.
- The sibling proof repository software-is-a-closed-loop, which
  hosts the closed loop synthesis this model serves.
- The sibling proof repository software-is-quantifiable, which
  proves the accounting fold this model's accounting follows.

This repository proves the measurement model. It does not
re-prove the results of the sibling repositories.
