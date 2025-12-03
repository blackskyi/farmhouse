#!/bin/bash

echo "🔍 Testing og-rooms.com DNS and connectivity..."
echo ""

echo "1️⃣ DNS Lookup:"
nslookup og-rooms.com
echo ""

echo "2️⃣ Testing HTTP connection:"
curl -I https://og-rooms.com 2>&1 | head -10
echo ""

echo "3️⃣ Testing WWW subdomain:"
curl -I https://www.og-rooms.com 2>&1 | head -10
echo ""

echo "✅ If you see '200 OK' or '301/302 redirect', your domain is working!"
