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

## Update client data

1. Open the dashboard, unlock it, click **Edit mode**.
2. **Add client** or open a client → **Edit this client** (name, tier, verification,
   tags, Guru link, note, and the profile body as HTML).
3. Click **Export data** → downloads a fresh **encrypted** `clients.enc.json`
   (re‑encrypted with the current password).
4. Replace `clients.enc.json` in this repo with the download and commit + push:
   ```bash
   git add clients.enc.json && git commit -m "Update client data" && git push
   ```
   GitHub Pages redeploys automatically in ~1 minute.

---

## Rotate the password

1. Unlock the dashboard with the current password → **Edit mode**.
2. Click **Change password**, enter the new one twice.
3. Click **Export data** (re‑encrypts with the new password) → commit the new
   `clients.enc.json`.
4. Share the new password with the team. Old password no longer decrypts the new file.

> Forgot the password? Re‑encrypt from the plaintext backup in `PromptQL-source`
> (open its `clients.json` in a local copy of the dashboard and export with a new password).

---

## Run locally

```bash
cd PromptQL
python3 -m http.server 8000   # then open http://localhost:8000
```
If `clients.enc.json` is present you'll get the lock screen. (With a local plaintext
`clients.json` and no encrypted file, the app loads directly — handy for dev.)
