# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates a VPC peering connection from a requester VPC (`vpc_id`) to a peer VPC (`peer_vpc_id`) and accepts it on the peer side with the `aws.peer` provider alias. It can also add routes that target the connection, in either VPC, from the `routes` input; each route's `provider` is `aws` or `aws.peer`. It outputs the connection ID and its status as `vpc_peering_connection_id` and `vpc_peering_connection_status`.
