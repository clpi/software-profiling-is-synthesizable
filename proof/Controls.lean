/-
  Adversarial controls for the profiling model. Each control
  weakens one condition of the model and proves, by a concrete
  counterexample, that the corresponding theorem then fails.
  A control that stopped failing would mean the condition it
  weakens was never load bearing.
-/

import Profiling

namespace Profiling

/-- A baseline dependent measure: the weakened variant of the
    model value, in which the baseline place is used. -/
def dependent (overlap witness baseline : Nat) : Nat :=
  derived overlap witness + baseline

/-- Control one: baseline independence fails for the weakened
    variant. Two baselines give two values at the same overlap
    and the same witnesses, so the independence theorem cannot
    be proved of this variant. -/
theorem controlone :
    ¬ ∀ overlap witness first second,
      dependent overlap witness first
        = dependent overlap witness second := by
  intro h
  have h1 := h 0 0 0 1
  simp [dependent, derived] at h1

/-- Control two: reapplication invariance fails for a
    non idempotent effect. The successor effect applied twice
    accounts 2 from 0; applied once it accounts 1. -/
theorem controltwo :
    account [Nat.succ, Nat.succ] 0 ≠ account [Nat.succ] 0 := by
  decide

end Profiling

#print axioms Profiling.controlone
#print axioms Profiling.controltwo
