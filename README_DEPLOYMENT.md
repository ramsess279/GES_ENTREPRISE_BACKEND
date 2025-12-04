# Déploiement Backend sur Render

## ✅ Configuration pour Render (sans Docker)

Le backend est configuré pour être déployé directement sur Render sans Docker.

## 📋 Prérequis

- Compte Render (https://render.com)
- Repository Git séparé pour le backend
- Base de données PostgreSQL (Render ou externe)

## 🚀 Étapes de déploiement

### 1. Préparer le repository
```bash
cd /chemin/vers/votre/repo/backend
cp -r /home/rama/Documents/REACT/GESTION_EMPLOYER_ENTREPRISE/BACKEND/* ./
git add .
git commit -m "feat: déploiement backend sur Render"
git push origin main
```

### 2. Créer la base de données PostgreSQL

#### Option A : Base de données Render (Recommandé)
1. Dans Render Dashboard → "New" → "PostgreSQL"
2. Créer une base de données
3. Noter l'URL de connexion (commence par `postgresql://`)

#### Option B : Base de données externe
Utilisez Railway, Neon, Supabase, etc.

### 3. Déployer le backend

1. **Connecter le repository** :
   - Aller sur https://render.com
   - Cliquer "New" → "Web Service"
   - Connecter votre repository Git

2. **Configuration du service** :
   - **Name** : `gestion-salaires-backend`
   - **Runtime** : `Node`
   - **Build Command** : `npm install && npm run build`
   - **Start Command** : `npm run prod:start`

3. **Variables d'environnement** :
   ```
   NODE_ENV=production
   DATABASE_URL=postgresql://user:password@host:port/database
   JWT_SECRET=votre_jwt_secret_sécurisé
   PORT=10000
   FRONTEND_URL=https://votre-frontend.vercel.app
   ```

### 4. Configuration avancée

Le fichier `render.yaml` est inclus pour une configuration automatique, mais vous pouvez aussi configurer manuellement :

- **Health Check** : `/api/marketing`
- **Auto Deploy** : Activé
- **Instance Type** : Free (pour commencer)

## 🔧 Scripts disponibles

```json
{
  "scripts": {
    "build": "tsc",                    // Compile TypeScript
    "start": "node dist/server.js",    // Démarre en production
    "prod:start": "npm run prisma:migrate && npm run seed && npm run start",
    "prisma:migrate": "prisma migrate deploy",  // Migration en prod
    "seed": "tsx src/seeders/index.ts"          // Peuplement DB
  }
}
```

## 📊 Base de données

### Migration automatique
Le script `prod:start` exécute automatiquement :
1. `prisma migrate deploy` - Applique les migrations
2. `npm run seed` - Peuple la base avec les données de test
3. `npm start` - Démarre le serveur

### Données de test incluses
- 5 entreprises sénégalaises
- 10 utilisateurs avec différents rôles
- 14 employés
- Cycles de paie et bulletins
- Historique des paiements

## 🌐 Configuration finale

Après déploiement :
1. **Noter l'URL du backend** (ex: `https://gestion-salaires-backend.onrender.com`)
2. **Mettre à jour le frontend** : Modifier `REACT_APP_API_URL` dans Vercel
3. **Tester la connexion** : Vérifier que `/api/marketing` répond

## 🔑 Comptes de test

- **Super Admin** : `rama.gueye@odc.sn` / `passer123`
- **Admin** : `fatou.ndiaye@sonatel.sn` / `admin123`
- **Caissier** : `moussa.fall@sonatel.sn` / `caissier123`

## 📝 Architecture

- **Framework** : Express.js + TypeScript
- **Base de données** : PostgreSQL + Prisma ORM
- **Authentification** : JWT + bcrypt
- **API** : RESTful avec middleware d'autorisation
- **Uploads** : Gestion des fichiers (logos, reçus)

## 🚨 Points importants

1. **Variables sensibles** : Ne commitez jamais les vraies valeurs dans le code
2. **JWT Secret** : Utilisez un secret fort en production
3. **Database URL** : Assurez-vous que la DB est accessible depuis Render
4. **Health Check** : Le endpoint `/api/marketing` est utilisé pour vérifier la santé

## 🔧 Dépannage

### Erreur de build
- Vérifier que `npm install` réussit
- S'assurer que TypeScript compile sans erreur

### Erreur de base de données
- Vérifier la `DATABASE_URL`
- S'assurer que la DB est accessible depuis Render
- Vérifier les logs pour les erreurs Prisma

### Erreur de santé
- Vérifier que le serveur démarre sur le port 10000
- Tester l'endpoint `/api/marketing` manuellement

Le backend sera déployé et opérationnel automatiquement ! 🎉