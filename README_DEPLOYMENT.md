# Déploiement Backend sur Render

## Prérequis
- Compte Render (https://render.com)
- Repository Git séparé pour le backend

## Étapes de déploiement

### 1. Créer un nouveau service Web sur Render
1. Connectez votre repository Git
2. Choisissez "Web Service"
3. Sélectionnez le runtime "Docker"
4. Le Dockerfile sera automatiquement détecté

### 2. Configuration de la base de données
1. Dans votre dashboard Render, créez une nouvelle base de données PostgreSQL
2. Copiez l'URL de connexion fournie par Render
3. Dans les variables d'environnement de votre service web, ajoutez :
   - `DATABASE_URL` : URL de votre base PostgreSQL
   - `JWT_SECRET` : Générez un secret sécurisé
   - `NODE_ENV` : production

### 3. Variables d'environnement
Assurez-vous d'avoir ces variables configurées :
```
DATABASE_URL=postgresql://user:password@host:port/database
JWT_SECRET=votre_secret_jwt_sécurisé
NODE_ENV=production
FRONTEND_URL=https://votre-domaine.vercel.app
```

### 4. Déploiement automatique
Render déploiera automatiquement à chaque push sur la branche principale.

### 5. Migration de la base de données
Les migrations Prisma s'exécutent automatiquement au démarrage grâce au Dockerfile.

## Commandes importantes
```bash
# Construire localement pour tester
docker build -t backend .

# Tester localement
docker run -p 4000:4000 -e DATABASE_URL=your_db_url backend
```

## Dépannage
- Vérifiez les logs Render pour les erreurs
- Assurez-vous que la base de données est accessible
- Vérifiez les variables d'environnement