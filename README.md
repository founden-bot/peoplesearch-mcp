# PeopleSearch.im MCP server

Give your AI agent [PeopleSearch.im](https://peoplesearch.im/mcp?utm_source=github&utm_medium=readme&utm_campaign=mcp-repo):
search a global professional database in plain English, reveal full profiles, and fetch verified
professional (work) emails, plus email verification, reverse email lookup, LinkedIn lookups, and company
lookups. Searching is free; most lookups cost 1 credit and are refunded automatically when nothing is found.

Listed in the [Official MCP Registry](https://registry.modelcontextprotocol.io) as `im.peoplesearch/email-finder`.

## Connect (remote server, recommended)

No install. The server runs at:

```
https://peoplesearch.im/api/mcp
```

Searching people and companies works without an account a few times a day. When your assistant needs a
tool that spends credits, it asks you to sign in and approve the connection (OAuth), with no API key to
copy. Your first search is free, then credit packs from $5, with no subscription.

**ChatGPT:** install the PeopleSearch.im app from ChatGPT's app directory, or add the URL above as a custom
connector (choose OAuth).

**Claude:** add the URL above as a custom connector (Settings > Connectors).

**Claude Code:**

```bash
claude mcp add --transport http peoplesearch https://peoplesearch.im/api/mcp
```

**Cursor** (`~/.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "peoplesearch": {
      "url": "https://peoplesearch.im/api/mcp"
    }
  }
}
```

**VS Code** (`.vscode/mcp.json`):

```json
{
  "servers": {
    "peoplesearch": {
      "type": "http",
      "url": "https://peoplesearch.im/api/mcp"
    }
  }
}
```

### Prefer an API key? (Windsurf, scripts, clients without OAuth)

Create a key (`sk_sift_...`) on the
[developer page](https://peoplesearch.im/developers?utm_source=github&utm_medium=readme&utm_campaign=mcp-repo)
and send it as a Bearer header:

```bash
claude mcp add --transport http peoplesearch https://peoplesearch.im/api/mcp \
  --header "Authorization: Bearer sk_sift_..."
```

```json
{
  "mcpServers": {
    "peoplesearch": {
      "serverUrl": "https://peoplesearch.im/api/mcp",
      "headers": { "Authorization": "Bearer sk_sift_..." }
    }
  }
}
```

## Connect (local stdio bridge)

For clients that only speak stdio, this repository is a zero-dependency bridge (`index.mjs`, Node 18+). It
speaks MCP over stdio and forwards each tool call to the PeopleSearch.im REST API with your API key:

```json
{
  "mcpServers": {
    "peoplesearch": {
      "command": "npx",
      "args": ["-y", "github:founden-bot/peoplesearch-mcp"],
      "env": { "PEOPLESEARCH_API_KEY": "sk_sift_..." }
    }
  }
}
```

Or clone the repository and run `node index.mjs` with `PEOPLESEARCH_API_KEY` set.
`PEOPLESEARCH_BASE_URL` optionally overrides the API base (default `https://peoplesearch.im`).

## Tools

| Tool | What it does | Cost |
| --- | --- | --- |
| `people_search` | Search people in plain English or with exact filters (masked previews and the true total) | free |
| `company_search` | Search companies by description, website or name | free |
| `check_credits` | Your credit balance | free |
| `reveal_profile` | Unlock one person from a search result | 1 credit (+1 for the email) |
| `find_people` | Search and unlock a batch of people in one charge | 1 credit per person unlocked |
| `fetch_email` | Verified work email for an unlocked person | 1 credit (refunded if none) |
| `find_work_email` | A named person's verified work email from their name and company | 2 credits (refunded if none) |
| `find_email_from_linkedin` | The verified work email behind a LinkedIn profile URL | 3 credits (refunded if none) |
| `verify_email` | Check whether an address exists and is safe to send to | 1 credit (refunded if no verdict) |
| `find_company_emails` | Role-based addresses (sales@, support@...) for a company | 2 credits (refunded if none) |
| `find_linkedin_profile` | A person's LinkedIn URL from their name | 2 credits (refunded if no match) |
| `lookup_linkedin_profile` | Structured data from a LinkedIn profile URL | 2 credits (refunded if none) |
| `lookup_company` | Firmographics from a LinkedIn company URL | 1 credit (refunded if none) |
| `reverse_email_lookup` | The person behind a professional email | 13 credits (refunded if no match) |

Data comes from Icypeas, a B2B people-data provider. Emails are professional (work) addresses looked up
live, not personal ones. A lookup can come back empty, and then the credit is refunded.

## Links

- MCP setup guide: <https://peoplesearch.im/mcp?utm_source=github&utm_medium=readme&utm_campaign=mcp-repo>
- Developer docs and API keys: <https://peoplesearch.im/developers?utm_source=github&utm_medium=readme&utm_campaign=mcp-repo>
- Pricing: <https://peoplesearch.im/pricing?utm_source=github&utm_medium=readme&utm_campaign=mcp-repo>
- OpenAPI spec: <https://peoplesearch.im/openapi.json>

## License

[MIT](LICENSE)
