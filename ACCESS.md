# Access & Hosting — PRMT Client Directory

The dashboard is protected by **one shared team password**. The client data
(`clients.enc.json`) is **AES‑256‑GCM encrypted**; the password is never stored in
this repo. When someone opens the site they get a lock screen and must enter the
password to decrypt the data in their browser. That's why this repo can safely be
**public** on GitHub Pages — without the password, the published data is just ciphertext.

- **Encryption:** AES‑256‑GCM, key derived with PBKDF2‑HMAC‑SHA256, 310,000 iterations.
- **Password:** shared out‑of‑band with the team (not in this repo). Rotate anytime (below).
- The plaintext (`clients.json`) is **git‑ignored** and must never be committed here.
  The full plaintext + history lives in the private repo **`watheeq-prmt/PromptQL-source`**.

---

## Publish on GitHub Pages (one‑time)

1. Push this repo to GitHub as **public** (already done if you're reading this there).
2. On GitHub: **Settings → Pages → Build and deployment.**
   - **Source:** Deploy from a branch
   - **Branch:** `main` · folder `/ (root)` → **Save**
3. Wait ~1 minute. Your link appears at the top of the Pages settings, e.g.
   `https://watheeq-prmt.github.io/PromptQL/`
4. Pin that link in PromptQL. Teammates click it, enter the shared password once per
   browser session, and they're in.

> The password is cached in the browser's **session** storage only — it clears when the
> browser is closed, so shared/public machines re‑prompt.

---

## Data model

Each client shows every card from its Guru board as an expandable section. Images are
optimized and **individually AES‑encrypted** as `img/<hash>.enc` files, decrypted in the
browser only when their card is opened (so a public repo never exposes them, and pages
load fast). The card bodies + metadata live in the encrypted `clients.enc.json`. Both the
data and the images are encrypted with the key derived from the team password — they share
one key, so the salt must stay stable (the app handles this automatically on export).

## Update client text (in‑app)

1. Open the dashboard, unlock it, click **Edit mode**.
2. **Add client** or open a client → **Edit this client** (name, tier, tags, Guru link,
   note, and the profile body as HTML).
3. Click **Export data** → downloads a re‑encrypted `clients.enc.json` (reusing the same
   salt, so images keep working).
4. Replace `clients.enc.json` in this repo with the download and commit + push:
   ```bash
   git add clients.enc.json && git commit -m "Update client data" && git push
   ```
   GitHub Pages redeploys automatically in ~1 minute.

> In‑app edits change **text only**. Adding/removing **images** or **rotating the password**
> re‑encrypts the image files too, which is a local rebuild (below) — not an in‑app action.

---

## Rebuild from a Guru export (new images, new cards, or password rotation)

The full dataset (all board cards + encrypted images) is generated from a Guru **Export
Collection** download. The build script and the plaintext data live in the **private** repo
`watheeq-prmt/PromptQL-source` (kept private on purpose — the build inputs contain client
names and notes in the clear). To refresh content or rotate the password: re‑export the
Clients collection from Guru, run the build there with the desired password, then commit the
regenerated `clients.enc.json` + `img/` to this public repo. GitHub Pages redeploys in ~1 min.

---

## Run locally

```bash
cd PromptQL
python3 -m http.server 8000   # then open http://localhost:8000
```
If `clients.enc.json` is present you'll get the lock screen. (With a local plaintext
`clients.json` and no encrypted file, the app loads directly — handy for dev.)
