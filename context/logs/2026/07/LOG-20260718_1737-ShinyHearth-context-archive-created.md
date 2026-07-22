---
apiVersion: processkit.projectious.work/v2
kind: LogEntry
metadata:
  id: LOG-20260718_1737-ShinyHearth-context-archive-created
  created: '2026-07-18T17:37:48+00:00'
spec:
  event_type: context_archive.created
  timestamp: '2026-07-18T17:37:48+00:00'
  summary: Archived 3 context entities into ARCHIVE-20260718_173747-migration-applied
  subject: ARCHIVE-20260718_173747-migration-applied
  subject_kind: Archive
  actor: processkit-context-archiving
  details:
    archive_path: context/archives/2026/07/ARCHIVE-20260718_173747-migration-applied.tar.gz
    manifest_path: context/archives/2026/07/ARCHIVE-20260718_173747-migration-applied.json
    entity_ids:
    - MIG-20260718_1724-RuntimeSync-aibox-runtime
    - MIG-20260717T135019
    - MIG-LOCK-20260717T121607
---
