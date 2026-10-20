# Azure Enterprise Landing Zone — Governance (Terraform)

> Management group hierarchy, an Azure Policy guardrail, and RBAC — the governance backbone of an Azure landing zone, provisioned with Terraform.
> **Author:** Muhammad Ahmad · **IaC:** Terraform · **Cloud:** Azure

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-7B42BC?logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-Management%20Groups%20%7C%20Policy%20%7C%20RBAC-0078D4?logo=microsoftazure&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Overview

- A **management group hierarchy**: a `platform` parent with `landingzones` and `sandbox` children.
- An **Azure Policy** assignment (built-in *Allowed locations*) on the platform group, so every child subscription can only deploy into approved regions.
- A **RBAC** role assignment (`Reader`) scoped to the Landing Zones group.

This is the structure you apply before onboarding workload subscriptions.

## 🏗️ Architecture

```mermaid
flowchart TB
    Platform[Platform MG]
    LZ[Landing Zones MG]
    SBX[Sandbox MG]
    Policy[Allowed Locations Policy]
    RBAC[Reader Role Assignment]

    Platform --> LZ
    Platform --> SBX
    Policy -.assigned.-> Platform
    RBAC -.scoped.-> LZ
```

## ⚠️ Prerequisites

Run with an identity that has **Management Group Contributor** and the rights to create policy/role assignments at the tenant root.

## 🚀 Deploy

```bash
cd terraform
az login
terraform init
terraform apply
```

## 🧹 Clean up

```bash
terraform destroy
```

## 🔐 Production hardening (next steps)

- Add a full **CAF management-group** tree (Decommissioned, Connectivity, Identity).
- Assign **policy initiatives** (Security Benchmark) with `deployIfNotExists`.
- Drive RBAC from **Azure AD groups**, not individual principals.

---

*Built and maintained by **Muhammad Ahmad**.*
