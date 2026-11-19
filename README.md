# AWS Static Website: S3 + CloudFront

A personal portfolio site hosted on AWS using a private S3 bucket served globally through CloudFront (HTTPS, Origin Access Control). Built as a hands-on project to practice core AWS services and document the architecture.

**Live demo:** https://d2pr08qv0vkzdl.cloudfront.net
## Architecture

```
User ──HTTPS──> CloudFront (CDN, TLS) ──OAC──> S3 bucket (private)
```

| Component | Purpose |
|-----------|---------|
| Amazon S3 | Stores the static files (HTML/CSS). Public access fully blocked. |
| CloudFront | Global CDN, HTTPS, caching. Only entry point to the content. |
| Origin Access Control (OAC) | Lets CloudFront read the private bucket; nobody else can. |
| IAM | Least-privilege access for the deploying user. |

## Design decisions

- **Private bucket + OAC** instead of S3 website hosting: no public bucket, HTTPS by default, aligned with the Security pillar of the AWS Well-Architected Framework.
- **CloudFront default domain** first; a custom domain with Route 53 and ACM can be added later.
- **Cost:** a static site of this size stays within the AWS Free Tier. A budget alert is configured.

## Deployment (manual, via console)

See [docs/deployment-steps.md](docs/deployment-steps.md)\
See architecture design [docs/architecture.png](https://github.com/marcosanzone/aws-static-site/blob/main/docs/architecture.png)

## Roadmap

- [x] Manual deployment via AWS Console
- [ ] Rebuild the infrastructure with Terraform (Infrastructure as Code)
- [ ] CI/CD with GitHub Actions (auto-deploy on push)
- [ ] Custom domain with Route 53 + ACM certificate

## What I learned

## What I learned

- **A wrong default root object looks like a permissions error.** CloudFront returned `AccessDenied` instead of a 404. With a private bucket and Origin Access Control, S3 hides missing objects, so a configuration typo is easy to mistake for a bucket policy problem.
- **The root cause was a typo.** The distribution's Default root object was set to `index.htm`, while the file in the bucket is `index.html`. The names must match exactly.
- **The same error came back after my first fix**, which cost me extra debugging time. I narrowed it down by requesting `/index.html` directly and re-checking the object name in S3 against the root object setting in CloudFront.
- **Debugging approach that worked:** test the direct path (`/index.html`), compare object key and root object character by character, and verify the bucket policy and origin settings one at a time instead of changing everything at once.
- **Security stayed intact:** I never made the bucket public to "make it work". Block Public Access remains on, and CloudFront is the only way in.

*(Fill this in after deploying: 3-5 bullet points on what worked, what broke, how you fixed it. Recruiters love this section.)*

## Author

Marco Sanzone: IT Infrastructure & Cloud Consultant
LinkedIn: https://www.linkedin.com/in/marcosanzone/
