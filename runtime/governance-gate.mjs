export function evaluateGovernance({ deed, action, finding = 'confirmed', trust = 'high_trust' }) {
  if (!deed) {
    return { allowed: false, reason: 'No deed attached' };
  }

  if (deed.authority !== 'active') {
    return { allowed: false, reason: 'Deed is not active' };
  }

  if (deed.restrictions?.includes(action)) {
    return { allowed: false, reason: 'Action blocked by deed restriction' };
  }

  if (!deed.powers?.includes(action)) {
    return { allowed: false, reason: 'Action outside deed scope' };
  }

  if (finding !== 'confirmed' && trust !== 'high_trust') {
    return { allowed: false, reason: 'Escalation requires confirmed finding and high trust' };
  }

  return { allowed: true, reason: 'Governance gate passed' };
}
