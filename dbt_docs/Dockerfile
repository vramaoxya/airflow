# Dockerfile.docs
# Utilise une image Nginx très légère (alpine) comme serveur de base
FROM nginx:stable-alpine 

# Métadonnées (optionnel mais bonne pratique)
LABEL maintainer="DataBird"

# --- Configuration de Nginx ---
# Supprime le fichier de configuration par défaut de Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copie le fichier de configuration personnalisé
# Vous devez créer ce fichier 'nginx.conf' à côté de votre Dockerfile.docs
COPY nginx.conf /etc/nginx/conf.d/dbt-docs.conf

# --- Préparation des Fichiers de Documentation ---
# Crée le répertoire où les fichiers de documentation dbt seront montés
# Ceci doit correspondre au chemin de montage dans votre docker-compose.yml
# (volumes: - ./dbt_project/target:/usr/share/nginx/html/dbt-docs)
RUN mkdir -p /usr/share/nginx/html/dbt-docs

# Le conteneur expose le port 80 (c'est le port interne)
EXPOSE 80

# La commande par défaut de Nginx pour démarrer le serveur
CMD ["nginx", "-g", "daemon off;"]
