# FER3OON Backend API

## Setup Instructions

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Edit `.env` file and update:
- `MONGODB_URI`: Your MongoDB Atlas connection string
- `JWT_SECRET`: Change to a secure random string
- `PORT`: Default is 5000

### 3. MongoDB Atlas Setup
1. Create account at https://www.mongodb.com/cloud/atlas
2. Create a new cluster (free tier available)
3. Create database user with password
4. Whitelist all IP addresses (0.0.0.0/0) for Railway
5. Get connection string and update `.env`

### 4. Deploy to Railway

#### Method 1: Railway CLI
```bash
npm install -g @railway/cli
railway login
railway init
railway up
```

#### Method 2: Railway Dashboard
1. Go to https://railway.app
2. Sign up/Login with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Railway will auto-detect Node.js
6. Add environment variables in Railway dashboard:
   - MONGODB_URI
   - JWT_SECRET
   - ADMIN_USERNAME=FADY
   - ADMIN_PASSWORD=AMIRA
   - NODE_ENV=production
7. Deploy!

### 5. Get Your API URL
After deployment, Railway will provide a URL like:
`https://your-project-name.up.railway.app`

### 6. Test the API
```bash
# Health check
curl https://your-api-url/health

# Should return: {"status":"OK","message":"pong"}
```

### 7. Setup Uptime Monitoring
Use a free service like:
- UptimeRobot (https://uptimerobot.com)
- Pingdom
- StatusCake

Monitor this endpoint: `https://your-api-url/ping`

## API Endpoints

### Public Endpoints (Mobile App)
- `POST /api/users/register` - Register/login user
- `GET /api/users/status` - Check user status
- `POST /api/users/signal` - Generate trading signal

### Admin Endpoints (Dashboard)
- `POST /api/auth/login` - Admin login
- `GET /api/auth/verify` - Verify token
- `GET /api/users` - Get all users
- `GET /api/users?status=PENDING` - Filter by status
- `PUT /api/users/:userId/status` - Update user status
- `GET /api/stats` - Get dashboard statistics

## Environment Variables
```
PORT=5000
MONGODB_URI=mongodb+srv://...
JWT_SECRET=your_secret_key
NODE_ENV=production
ADMIN_USERNAME=FADY
ADMIN_PASSWORD=AMIRA
```

## Local Development
```bash
npm run dev
```

## Production
```bash
npm start
```
