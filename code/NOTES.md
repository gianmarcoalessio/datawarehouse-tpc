### Hardware description

Hardware was rented from the DigitalOcean Platform with these specs:

•⁠  ⁠vCPU (Virtual CPU): DO-Premium-Intel @ 4988.27 MHz (1 core, 1 thread)
•⁠  ⁠RAM: 2 GB RAM
•⁠  ⁠Storage: 70 GB Disk, NVMe SSD
•⁠  ⁠GPU: Virtio GPU (virtualized)
•⁠  ⁠OS: Ubuntu 22.04.4 LTS x86_64

### Database performance (no optimization)

Query 1 Execution time:
- 1899.579 ms (query1_20240310_112704)
- 2175.245 ms (query1_20240310_113004)
- 1648.740 ms (query1_20240310_113007)

Notes:
- **Nested Loops and Hash Joins**: These can potentially be made more efficient through indexing.
- **Unused Indexes**: The orders_pkey and customer_pkey were not used in this plan, which might indicate an indexing opportunity or the need to review the query.

Query 1 Indexed Execution time:
- 1490.628 ms (query1_indexed_20240310_113417)
- 1465.792 ms (query1_indexed_20240310_113420)
- 1567.175 ms (query1_indexed_20240310_113423)

Query 3 Execution time:


# TODO
repeat queries x25 and take mean and std