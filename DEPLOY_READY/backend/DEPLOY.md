# FER3OON Backend - Deployment Guide

## 🚀 Deploy to Railway

### Step 1: Setup MongoDB Atlas
1. Go to https://mongodb.com/cloud/atlas
2. Create free cluster
3. Create database user
4. Whitelist IP: `0.0.0.0/0` (allow all)
5. Get connection string

### Step 2: Deploy Backend
1. Push code to GitHub
2. Go to https://railway.app
3. New Project → Deploy from GitHub
4. Select this repository
5. Add Environment Variables:
   ```
   MONGODB_URI=your_mongodb_connection_string
   JWT_SECRET=your_random_secret_key
   ADMIN_USERNAME=FADY
   ADMIN_PASSWORD=AMIRA
   NODE_ENV=production
   ```
6. Deploy!

### Step 3: Get API URL
After deployment, Railway gives you a URL like:
`https://your-project.up.railway.app`

**Save this URL - you'll need it for Frontend & Mobile App!**

## 📡 API Endpoints

### Public (Mobile App)
- `POST /api/users/register` - Register user
- `GET /api/users/status` - Check status
- `POST /api/users/signal` - Generate signal

### Admin (Dashboard)
- `POST /api/auth/login` - Admin login
- `GET /api/users` - Get all users
- `PUT /api/users/:userId/status` - Update status
- `GET /api/stats` - Statistics

### Health Check
- `GET /health` - Returns `pong`
- `GET /ping` - Returns `pong`

## ✅ Verification
Test your deployment:
```bash
curl https://your-api-url/health
```

Should return: `{"status":"OK","message":"pong"}`

## 🔧 Local Development
```bash
npm install
npm run dev
```
