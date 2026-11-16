# Deployment steps (AWS Console)

Region: pick one close to you (e.g. eu-south-1 Milan or eu-west-1 Ireland). The CloudFront certificate/region constraints only matter if you add a custom domain later.

## 0. Safety first (do this before anything else)

1. Sign in to the root account only to set up security, then stop using it.
2. Enable **MFA** on the root account.
3. Billing -> **Budgets** -> create a monthly cost budget of 5 EUR with an email alert at 80%.
4. IAM Identity Center or an IAM user with MFA for daily work. Never create access keys for the root account.
5. **Never commit credentials to GitHub.** No access keys, no .env files, no screenshots showing account IDs and keys.

## 1. Create the S3 bucket

1. S3 -> Create bucket -> unique name, e.g. `marcosanzone-static-site-2026`.
2. Keep **Block all public access = ON**.
3. Leave default encryption (SSE-S3) enabled.
4. Upload `site/index.html`.

## 2. Create the CloudFront distribution

1. CloudFront -> Create distribution.
2. Origin domain: select your S3 bucket (not the website endpoint).
3. Origin access: **Origin access control settings (recommended)** -> Create new OAC.
4. Viewer protocol policy: **Redirect HTTP to HTTPS**.
5. Default root object: `index.html`.
6. Create. AWS shows a **bucket policy** banner: copy it.

## 3. Allow CloudFront to read the bucket

1. S3 -> your bucket -> Permissions -> Bucket policy -> paste the policy CloudFront gave you -> Save.
2. Wait a few minutes until the distribution status is **Deployed**.

## 4. Test

Open `https://<distribution-domain>.cloudfront.net`. Direct S3 URLs must return Access Denied: that confirms the bucket is private.

## 5. Document it

- Add 2-3 screenshots (hide account ID) to a `docs/` folder.
- Draw the architecture diagram (draw.io is free) and save it as `docs/architecture.png`.
- Fill in the "What I learned" section of the README.

## 6. Clean up (to avoid costs)

If you stop using it: disable and delete the CloudFront distribution, empty and delete the bucket.
