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
Vous utilisez déjà une base PostgreSQL déployée sur Railway. Assurez-vous que :

1. Votre base Railway est accessible depuis Render
2. Vous avez l'URL de connexion Railway
3. Les tables sont créées (les migrations s'exécuteront automatiquement)

### 3. Variables d'environnement
Dans les settings de votre service Render, configurez :
```
DATABASE_URL=postgresql://postgres:UPfYQbzBTmaqJeHShFYgeHHpkLyCfHXE@shuttle.proxy.rlwy.net:53509/railway
JWT_SECRET=votre_secret_jwt_sécurisé
NODE_ENV=production
FRONTEND_URL=https://votre-domaine.vercel.app
```

⚠️ **Important** : Utilisez exactement la même URL DATABASE_URL que celle dans votre fichier `.env` local.

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