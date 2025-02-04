Intel Support
=============

Accelerated packet capture and trasmission for Intel adapters is available
on PF_RING ZC by means of specialised drivers as described in the 
`PF_RING ZC <https://www.ntop.org/guides/pf_ring/zc.html>`_ section.
Please also read `Installing from packages <https://www.ntop.org/guides/pf_ring/get_started/packages_installation.html>`_
for installation and configuration instructions.

Supported Intel NICs Comparison
-------------------------------

This table below helps you understanding what features are delivered by each Intel driver family and chipset model.

+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
|                           |   e1000e   |     igb    |    ixgbe   |   ixgbevf  |    i40e   |    iavf   |    fm10k   |    ice    |
+===========================+============+============+============+============+===========+===========+============+===========+
| Status                    |  Supported |  Supported |  Supported | Supported  | Supported | Supported | Deprecated | Supported |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| Max Port Speed (Gbit)     |      1     |      1     |     10     |     10     |     40    |     40    |     100    |    100    |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| Symmetric RSS             |   No RSS   |     Yes    |    Yes     |    Yes     | Dep on Fw | Dep on Fw |     Yes    |    Yes    |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| RX Hardware Timestamp     |            | 82580/i350 |            |            |           |           |            |    Yes    |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| Read/Set Device Clock     |            |            |            |            |           |           |            |    Yes    |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| TX Timestamp              |            |            |            |            |           |           |            |    Yes    |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
| ZC only (no kernel func.) |            |            |            |            |           |    Yes    |            |           |
+---------------------------+------------+------------+------------+------------+-----------+-----------+------------+-----------+
