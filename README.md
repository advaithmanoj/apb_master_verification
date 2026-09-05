# APB Master Verification using SystemVerilog

A SystemVerilog-based verification environment for validating an **AMBA APB Master** DUT. The testbench models the **APB Slave side** of the interface and generates randomized slave responses while monitoring and checking APB master transactions.

> **Project Type:** RTL Protocol Verification
> **Language:** SystemVerilog
> **Verification Methodology:** Class-based SystemVerilog Testbench
> **Protocol:** AMBA APB
> **DUT:** APB Master
> **Status:** Functional verification environment

---

## 1. Project Objective

The objective of this project is to develop a reusable SystemVerilog verification environment for an **APB Master** and verify that it correctly generates APB transactions according to the protocol.

The testbench acts as an APB Slave and provides the master with:

* `PREADY`
* `PRDATA`

The APB Master DUT generates:

* `PSEL`
* `PENABLE`
* `PADDR`
* `PWRITE`
* `PWDATA`

The verification environment monitors these signals and compares the observed transactions against the expected behavior.

The project focuses on understanding and implementing fundamental verification concepts including:

* Object-oriented SystemVerilog
* Randomization
* Mailbox-based communication
* Driver/monitor architecture
* Scoreboard-based checking
* Virtual interfaces
* Clocking blocks

---

# 2. DUT and Testbench Architecture

The DUT is an **APB Master**. Since the DUT requires an APB Slave to respond to its transactions, the verification environment implements the slave behavior.

### High-Level Architecture

to be added

# 3. APB Protocol Overview

The Advanced Peripheral Bus (APB) is a low-complexity synchronous protocol commonly used for connecting low-bandwidth peripherals.

An APB transfer consists primarily of two phases:

### Setup Phase

```text
PSEL    = 1
PENABLE = 0
```

The master places the address, direction and write data on the bus.

### Access Phase

```text
PSEL    = 1
PENABLE = 1
```

The master waits for the slave to assert:

```text
PREADY = 1
```

For a read transaction, the slave provides:

```text
PRDATA
```

The verification environment models this slave-side response.

---

# 4. Repository Structure

```text
apb_master_verification/
│
├── tb/
│   ├── apb_slave_transaction.sv
│   ├── apb_slave_generator.sv
│   ├── apb_slave_driver.sv
│   ├── apb_slave_monitor.sv
│   ├── apb_slave_agent.sv
│   ├── apb_slave_scoreboard.sv
│   ├── apb_slave_environment.sv
│   ├── apb_slave_pkg.sv
│   └── tb.sv
│
└── README.md
```

The repository currently organizes the complete verification environment under `tb/`.

---




# 5. Current Verification Status

| Feature                    | Status                             |
| -------------------------- | ---------------------------------- |
| APB interface              | ✅                                  |
| Transaction class          | ✅                                  |
| Randomization              | ✅                                  |
| Generator                  | ✅                                  |
| Driver                     | ✅                                  |
| Monitor                    | ✅                                  |
| Agent                      | ✅                                  |
| Scoreboard                 | ✅                                  |
| Mailbox communication      | ✅                                  |
| Transaction checking       | ✅                                  |
| Functional coverage        | 🔄 Planned                         |
| Code coverage              | 🔄 Planned                         |
| SVA assertions             | 🔄 Planned                         |
| UVM migration              | 🔄 Planned                         |
---


# 17. Project Takeaway

This project was developed to build practical experience in **RTL protocol verification using SystemVerilog**.

Rather than directly starting with a large UVM environment, the verification architecture was developed from the fundamentals:

```text
Transaction
     ↓
Generator
     ↓
Mailbox
     ↓
Driver
     ↓
Interface
     ↓
DUT
     ↓
Monitor
     ↓
Mailbox
     ↓
Scoreboard
     ↓
PASS / FAIL
```

This provides a foundation for moving toward more advanced verification methodologies such as **UVM, constrained-random verification, functional coverage and assertion-based verification**.

---

## Author

**Advaith Manoj**

RTL Design & Verification | SystemVerilog | APB | UVM


