# 🚀 FER3OON - Complete Deployment Guide

## 📦 Project Structure
```
DEPLOY_READY/
├── backend/          # Node.js + Express + MongoDB
├── dashboard/        # React + Vite Admin Dashboard
└── mobile/           # Flutter Android App
```

## ⚡ Quick Start - Deployment Order

### 1️⃣ BACKEND FIRST (20 minutes)
**Why first?** You need the backend URL for dashboard and mobile app.

📂 Go to `backend/` folder
📖 Read `DEPLOY.md`

**Steps:**
1. Setup MongoDB Atlas (free tier)
2. Deploy to Railway
3. Add environment variables
4. **SAVE THE URL** - you'll need it!

**URL Format:** `https://your-project.up.railway.app`

---

### 2️⃣ DASHBOARD SECOND (10 minutes)
**Requires:** Backend URL from Step 1

📂 Go to `dashboard/` folder
📖 Read `DEPLOY.md`

**Steps:**
1. Update `.env` with backend URL
2. Deploy to Railway
3. Login with FADY/AMIRA

**URL Format:** `https://your-dashboard.up.railway.app`

---

### 3️⃣ MOBILE APP LAST (15 minutes)
**Requires:** Backend URL from Step 1

📂 Go to `mobile/` folder
📖 Read `BUILD.md`

**Steps:**
1. Update `lib/core/constants.dart` with backend URL
2. Run `flutter build apk --release`
3. Install APK on Android device

**APK Location:** `build/app/outputs/flutter-apk/app-release.apk`

---

## 🔗 Important URLs to Save

After deployment, you'll have:

| Component | URL | Used By |
|-----------|-----|---------|
| **Backend API** | `https://xxx.up.railway.app` | Dashboard + Mobile |
| **Dashboard** | `https://yyy.up.railway.app` | Admin access |
| **Mobile APK** | `app-release.apk` | Android users |

---

## ✅ Verification Checklist

### Backend ✓
- [ ] MongoDB Atlas connected
- [ ] Deployed to Railway
- [ ] `/health` endpoint returns `pong`
- [ ] Environment variables set

### Dashboard ✓
- [ ] Deployed to Railway
- [ ] Can login with FADY/AMIRA
- [ ] Can see statistics
- [ ] Can manage users

### Mobile App ✓
- [ ] Backend URL updated in constants.dart
- [ ] APK builds successfully
- [ ] App connects to backend
- [ ] Can register with UID
- [ ] WebView loads Quotex

---

## 🆘 Common Issues & Solutions

### Backend won't start
- ❌ Check MongoDB connection string
- ❌ Verify environment variables
- ✅ Check Railway logs

### Dashboard can't connect
- ❌ Wrong backend URL in `.env`
- ❌ CORS not enabled on backend
- ✅ Check backend is running

### Mobile app errors
- ❌ Wrong backend URL in constants.dart
- ❌ Internet permission missing
- ✅ Run `flutter clean` then rebuild

---

## 📞 Support

- Telegram: http://t.me/el_fer3oon
- Registration: https://broker-qx.pro/?lid=1635606

---

## 🎯 Final Notes

**⚠️ IMPORTANT:**
1. Always deploy **BACKEND FIRST**
2. Use the backend URL in dashboard and mobile
3. Test each component before moving to next
4. Keep all URLs saved in a safe place

**✅ SUCCESS CRITERIA:**
- Backend health check returns `pong`
- Dashboard login works
- Mobile app connects and registers users
- Signals generate correctly
- Auto-block works on multiple devices

---

## 🔧 Tech Stack Summary

| Component | Technologies |
|-----------|--------------|
| **Backend** | Node.js, Express, MongoDB Atlas, JWT |
| **Dashboard** | React 18, Vite, React Router, Axios |
| **Mobile** | Flutter, Dart, WebView, Shared Preferences |
| **Hosting** | Railway (Backend + Dashboard) |

---

**Version:** 1.0.0  
**Last Updated:** February 2026  
**Status:** Production Ready ✅
