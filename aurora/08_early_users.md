# Early User Notes

The stability of the Aurora system has improved significantly over the months leading up to production availability, but its important to remember this is the first year of production. Unfortunately, stability issues remain (as it typical) and we encourage users to be proactive monitoring their jobs for expected behavior, reporting issues, and working with us on solutions.

## Outages and downtime

The current plan for Aurora includes weekly maintenance, typically on Mondays. There may be times where maintenance is canceled or delayed and we encourage users to watch for announcements in the aurora-notify list. Unfortunately, there may also be unplanned outages and downtime as well. We expect the frequency of downtime to decrease as the system stabilizes.

## Scheduling

Similar to other production ALCF systems, Aurora has a tiered scheduling policy ([see queues](https://docs.alcf.anl.gov/aurora/running-jobs-aurora/)) whereby larger jobs can request longer maximum walltimes. To help ensure a positive user experience, users and projects may initially be restricted to a limited number of nodes until they can demonstrate successful running of their workloads. We very much want to enable teams to leverage the full system to achieve their science goals. See the current [queue policy](https://docs.alcf.anl.gov/aurora/running-jobs-aurora/) for exact node and walltime limits.

## Storage

<!-- OUTDATED (2026-07): this said cross-mounting other ALCF filesystems was planned
     "possibly May 2025" — that date is now past. As of this update Aurora still uses a
     separate home (gecko-home) and project (flare) filesystem. Verified against
     https://docs.alcf.anl.gov/data-management/filesystem-and-storage/ (2026-07).
Aurora currently has separate home (Gecko) and project (flare) filesystems today. The plan is to cross-mount the other ALCF filesystems in the near future (possibly May 2025).
-->
Aurora has a separate home (`gecko-home`, at `/lus/gecko/home`) and project (`flare`, at `/lus/flare/projects`) filesystem. For the current, authoritative list of which filesystems are mounted on Aurora, see the [filesystem and storage documentation](https://docs.alcf.anl.gov/data-management/filesystem-and-storage/).

## Checkpointing

Checkpoint is essential. We strongly encourage users to be mindful of potential instabilities or other issues and to regularly checkpoint to minimize the impact from such disruptions. This will be particularly important as the scale of runs increase. 

## Getting help to resolve issues

This [Early User Notes and Known Issues](https://docs.alcf.anl.gov/aurora/known-issues/) page will be updated regularly as Aurora stabilizes.

There are multiple avenues for getting assistance as users encounter issues. Users are encouraged to discuss issues with their ALCF points-of-contact (e.g. Catalyst team supporting INCITE and ALCC projects). 

The MyALCF [portal](https://my.alcf.anl.gov/#/dashboard) provides convenient access to project and allocation information, training resources, and user guides.

Users are encourage to report issues to [ALCF Support](mailto:support@alcf.anl.gov). It is important to provide job IDs, if you encounter issues while running on the system. Note, a support ticket may need to be created even after discussing with ALCF point-of-contact depending on the nature of the issue.

