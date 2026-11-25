# Installing the PeopleSearch.im MCP server (for AI agents such as Cline)

PeopleSearch.im is a hosted MCP server. There is nothing to build or clone.

## Option A: remote server (recommended)

Add this entry to the MCP settings file (for Cline: `cline_mcp_settings.json`):

```json
{
  "mcpServers": {
    "peoplesearch": {
      "type": "streamableHttp",
      "url": "https://peoplesearch.im/api/mcp"
    }
  }
}
```

That is enough for `people_search` and `company_search`, which answer without an account a few times a day.
The tools that spend credits (revealing a person, emails, LinkedIn and company lookups) need the user's
account. A client that supports MCP OAuth signs the user in on first use. Otherwise, ask the user for their
API key (it starts with `sk_sift_`; they create it at https://peoplesearch.im/developers) and add it as a header:

```json
{
  "mcpServers": {
    "peoplesearch": {
      "type": "streamableHttp",
      "url": "https://peoplesearch.im/api/mcp",
      "headers": { "Authorization": "Bearer sk_sift_..." }
    }
  }
}
```

## Option B: local stdio bridge (Node 18+)

For clients that only run local servers:

```json
{
  "mcpServers": {
    "peoplesearch": {
      "command": "npx",
      "args": ["-y", "peoplesearch-mcp"],
      "env": { "PEOPLESEARCH_API_KEY": "sk_sift_..." }
    }
  }
}
```

The bridge needs the API key for every tool.

## Check it works

Call `people_search` with `{"query": "product managers at Stripe in London"}`. It returns masked previews and
the total number of matches, and spends no credits. With a key set, `check_credits` returns the balance.
