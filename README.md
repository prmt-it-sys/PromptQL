# PRMT · Client Directory

An interactive, PRMT-branded dashboard for browsing and maintaining client information —
built to mirror our Guru "Clients" collection so the team has a fast, visual way to look up
contacts, addresses, network notes, and more, and to add/update clients over time.

> 🔒 **Password-protected.** The client data (`clients.enc.json`) is **AES-256-GCM
> encrypted**. Opening the site shows a lock screen; a shared team password decrypts the
> data in the browser. That's why this repo can be public — the published data is ciphertext
> without the password. See **[ACCESS.md](ACCESS.md)** for hosting, updating, and rotating
> the password. The plaintext (`clients.json`) is git-ignored and lives only in the private
> backup repo `watheeq-prmt/PromptQL-source`.

## What's here

| File | Purpose |
|------|---------|
| `index.html` | The entire dashboard — single-file app, no build step, no external deps (Outfit font loads from Google Fonts; otherwise self-contained). |
| `clients.enc.json` | The encrypted client data the dashboard loads and decrypts in-browser. |
| `assets/` | PRMT logo (`image-14-1.webp`) + favicon mark (`logo_prmt_White-Favicon.svg`). |
| `ACCESS.md` | Hosting (GitHub Pages), data updates, and password rotation. |

## Running it

The app fetches `clients.enc.json`, so serve it over HTTP (a `file://` open won't fetch):

```bash
cd PromptQL
python3 -m http.server 8000   # then open http://localhost:8000
```

## Updating client data

Built-in **Edit mode** (top-right):

1. Unlock, click **Edit mode**.
2. **Add client**, or open a client → **Edit this client** (name, tier, verification status,
   tags, Guru link, summary note, and the profile body as HTML — `<h1>` section headings,
   `<ul><li>` lists, `<p>` paragraphs).
3. Edits save to the browser session so you can preview them.
4. Click **Export data** → downloads a re-encrypted `clients.enc.json`; commit it to publish.
   (Full steps and password rotation in [ACCESS.md](ACCESS.md).)

## Branding

Matches prmt.com, pulled from the live site: the **Outfit** typeface, black `#050505` chrome,
electric-blue `#002BFF` primary accent, and lime `#D9FF42` pop, with the official white PRMT
wordmark (`assets/image-14-1.webp`) in the header and the PRMT mark
(`assets/logo_prmt_White-Favicon.svg`) as the favicon. All colors are CSS variables at the top
of `index.html` under `/* PRMT BRAND TOKENS */`.

## Data provenance

Extracted from the Guru **Clients** collection (`f46a8a25-78ae-4214-b181-185d8d5d455d`)
on 2026-07-01: 26 client cards. Images embedded in Guru cards render as placeholders that
link back to Guru (they require a Guru sign-in), rather than being copied out.
