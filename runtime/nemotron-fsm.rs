use std::collections::VecDeque;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FabricState {
    Idle,
    EnginesAttached,
    AuditReady,
    SummonsOpen,
    MetaLawyerActive,
    WormSealed,
}

#[derive(Debug, Clone)]
pub enum FabricEvent {
    AttachEngine(&'static str),
    AuditCase(&'static str),
    SummonKernel(&'static str),
    SpawnMetaLawyer(&'static str),
    SealReceipt(&'static str),
}

#[derive(Debug, Default)]
pub struct FabricLog {
    pub entries: VecDeque<String>,
}

impl FabricLog {
    pub fn push(&mut self, entry: impl Into<String>) {
        self.entries.push_back(entry.into());
    }
}

pub struct NemotronFabric {
    pub state: FabricState,
    pub log: FabricLog,
}

impl NemotronFabric {
    pub fn new() -> Self {
        Self {
            state: FabricState::Idle,
            log: FabricLog::default(),
        }
    }

    pub fn handle(&mut self, event: FabricEvent) -> Result<FabricState, String> {
        match (self.state, event) {
            (FabricState::Idle, FabricEvent::AttachEngine(engine)) => {
                self.log.push(format!("ATTACH {}", engine));
                self.state = FabricState::EnginesAttached;
            }
            (FabricState::EnginesAttached, FabricEvent::AuditCase(case_id)) => {
                self.log.push(format!("AUDIT {}", case_id));
                self.state = FabricState::AuditReady;
            }
            (FabricState::AuditReady, FabricEvent::SummonKernel(kernel)) => {
                self.log.push(format!("SUMMON {}", kernel));
                self.state = FabricState::SummonsOpen;
            }
            (FabricState::SummonsOpen, FabricEvent::SpawnMetaLawyer(profile)) => {
                self.log.push(format!("SPAWN {}", profile));
                self.state = FabricState::MetaLawyerActive;
            }
            (FabricState::MetaLawyerActive, FabricEvent::SealReceipt(receipt)) => {
                self.log.push(format!("SEAL {}", receipt));
                self.state = FabricState::WormSealed;
            }
            (state, _) => {
                return Err(format!("invalid transition from {:?}", state));
            }
        }

        Ok(self.state)
    }
}
