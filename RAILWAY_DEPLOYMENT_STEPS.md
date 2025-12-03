# Railway Deployment - Quick Steps

## Step 1: Add Environment Variables in Railway Dashboard

The browser should have opened Railway. Now:

1. **Find your project** "tranquil-growth" or "house-rental-site"
2. **Click on your service** (the deployment)
3. **Go to "Variables" tab**
4. **Click "+ New Variable"** for each of these:

### Required Environment Variables:

```
STRIPE_SECRET_KEY=sk_test_51SS5MAIR9lvakztLQgjIbTUg0YxTlzvk0Kbj4f8Ekt8qYvaeaQovqrXWvPxONWVfHKMvk11dN6l77wNLopZ6tsXD00xoffvlr3

STRIPE_PUBLISHABLE_KEY=pk_test_51SS5MAIR9lvakztLw0twYpzXjeI200DzaTxUf4UOibXGrbec94Euidc7cN1HP0SBXQhI4JEDQCE9BQWpxwwwvgyY00O7zqFuCX

STRIPE_CLIENT_ID=(Get this from Stripe Dashboard - should be open in another tab)

STRIPE_WEBHOOK_SECRET=(We'll update this after deployment)

PLATFORM_FEE_PERCENTAGE=12

PORT=3000

NODE_ENV=production
```

## Step 2: Get Stripe Connect Client ID

Check the Stripe dashboard tab (https://dashboard.stripe.com/settings/applications):

- Look for **"Client ID"** under the OAuth settings
- It starts with `ca_`
- Copy it and add to Railway variables above

## Step 3: Deploy

Once all variables are added:
1. Railway should automatically trigger a new deployment
2. If not, click **"Deploy"** or **"Redeploy"**
3. Wait for deployment to complete (2-3 minutes)

## Step 4: Get Your Railway URL

After deployment:
1. Go to **"Settings"** tab
2. Under **"Domains"**, find your Railway URL
3. It should be like: `https://house-rental-site-production.up.railway.app`

## Step 5: Update Webhook URL in Stripe

1. Go to: https://dashboard.stripe.com/test/webhooks
2. Click **"+ Add endpoint"**
3. **Endpoint URL:** `https://YOUR-RAILWAY-URL.up.railway.app/webhook/stripe`
4. **Events to listen for:**
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `checkout.session.completed`
   - `account.updated`
5. Click **"Add endpoint"**
6. **Copy the signing secret** (starts with `whsec_`)
7. **Go back to Railway → Variables**
8. **Update** `STRIPE_WEBHOOK_SECRET` with the new production secret

## Step 6: Test Payment!

1. Visit: `https://YOUR-RAILWAY-URL.up.railway.app/pay-rent.html`
2. Fill out the form
3. Use test card: `4242 4242 4242 4242`
4. Complete payment
5. You should be redirected to success page!

## Troubleshooting

**If deployment fails:**
- Check Railway logs for errors
- Verify all environment variables are set
- Make sure `package.json` and `Dockerfile` are committed

**If webhook doesn't work:**
- Verify webhook URL matches your Railway URL exactly
- Check webhook signing secret is correct
- Look at Railway logs for webhook errors

## Next Steps After Successful Deployment

Once payments work on production, we'll:
1. Re-enable the 88/12 split functionality
2. Test Connect account onboarding for owners
3. Verify split payments work correctly
