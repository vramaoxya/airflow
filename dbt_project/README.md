# Local Bike

Local Bike data Analyse

### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Commandes:

- dbt deps
- dbt compile
- dbt test -s assert_total_order_amount_is_positive
- dbt test --select tag:bronze
- dbt seed --select map seasons
- dbt test -- bronze
- dbt run --select bronze silver gold
- dbt build -s bronze silver gold
- dbt test -m bronze --store-failures

Generate docs :

- dbt docs generate
- "dbt docs serve"

---

## 🧭 Table des matières

1. [Introduction](#-lhistoire-de-local-bike)
2. [Une histoire ancrée dans la communauté](#-une-histoire-ancrée-dans-la-communauté)
3. [Des implantations stratégiques](#-des-implantations-stratégiques-pour-une-mission-nationale)
4. [Une stratégie au service de la mission](#-une-stratégie-au-service-de-la-mission)
5. [Une expérience avant tout](#-une-expérience-avant-tout)
6. [Votre mission](#-votre-mission)
7. [Schéma brut : Local Bike](#-schéma-brut--local-bike)
   - [Création du Dataset](#1️⃣-création-du-dataset)
   - [Création des Tables](#2️⃣-création-des-tables)
8. [Diagramme Relationnel](#-diagramme-relationnel-er-diagram)

---

# Cas Final

## 🚲 L’histoire de Local Bike

### Une passion transformée en vision pour l’avenir

**Alexander Anthony**, fondateur de **Local Bike**, a passé une décennie comme cycliste professionnel, participant aux plus grandes compétitions internationales, dont le **Tour de France**.  
Mais ce n’est pas seulement l’adrénaline des courses qui l’a marqué. Lors de ses entraînements en Europe, Alexander a découvert des villes où le vélo n’était pas uniquement un loisir, mais une **partie intégrante du mode de vie urbain**.

À son retour aux États-Unis, il a constaté un **manque criant d'infrastructures et de culture cycliste** dans les grandes métropoles.

En **2016**, avec son vélo comme seul partenaire, il a décidé de **raccrocher le casque** pour démarrer une mission ambitieuse :

> **Démocratiser l’usage du vélo aux États-Unis.**

Son objectif était clair : encourager les **mobilités douces** en offrant aux citadins les moyens de transformer leur façon de se déplacer, tout en améliorant leur santé et en réduisant leur empreinte carbone.

---

## 🌍 Une histoire ancrée dans la communauté

Le nom **Local Bike** trouve son origine dans les débuts modestes de l’entreprise.  
Alexander a commencé par organiser des **ateliers gratuits de réparation de vélos** dans son quartier de **Brooklyn, New York**.

Son but ? Créer une **communauté cycliste soudée et accessible à tous**.  
Lorsqu'il a ouvert sa première boutique, il voulait un nom qui reflète cette philosophie de proximité et d'appartenance.

> **Local Bike** incarne cette idée : un lieu de confiance où chaque client se sent chez lui, qu’il soit débutant ou expert.

> _« Un vélo n'est pas juste un moyen de transport ; c'est une manière de se connecter à sa ville, à sa communauté et à soi-même. »_  
> — _Alexander Anthony_

---

## 🗺️ Des implantations stratégiques pour une mission nationale

**Local Bike** a choisi ses points de vente avec soin, en tenant compte des besoins spécifiques des communautés locales et de leur potentiel à promouvoir les mobilités douces.  
**Santa Cruz**, **Baldwin**, et **Rowlett** ne sont pas de simples localisations géographiques : elles incarnent des **choix stratégiques** pour impacter durablement les modes de vie.

- **Santa Cruz, Californie** : Ville emblématique de l’outdoor, idéale pour les amateurs de cyclisme sur route et en montagne.
- **Baldwin, New York** : Localisation stratégique à Long Island pour desservir les familles et les navetteurs proches de New York City.
- **Rowlett, Texas** : Ville en pleine croissance près de Dallas, avec un fort potentiel pour développer la culture cycliste.

---

## 🎯 Une stratégie au service de la mission

À travers ces trois implantations, **Local Bike** ne se contente pas de vendre des vélos :  
l’entreprise **façonne activement des communautés** autour des mobilités douces.

En s’intégrant dans des environnements aussi divers que Santa Cruz, Baldwin et Rowlett, Local Bike incarne sa vision d’un avenir où **le vélo est au cœur de la vie quotidienne des Américains.**

---

## 💬 Une expérience avant tout

Depuis sa création, Local Bike se distingue par son **engagement envers l’expérience client**.  
Contrairement aux grandes enseignes, l’entreprise privilégie la **qualité** à la quantité.

Trois valeurs clés guident Local Bike :

1. **Personnalisation** :  
   Chaque client bénéficie d’une consultation approfondie pour choisir le vélo le plus adapté à son mode de vie, sa morphologie et ses besoins.

2. **Qualité** :  
   Tous les vélos, qu’ils soient destinés aux trajets quotidiens ou aux aventures du week-end, sont conçus pour durer, avec des matériaux haut de gamme et des garanties solides.

3. **Engagement communautaire** :  
   Local Bike organise régulièrement des événements, des cours de mécanique et des sorties collectives pour rassembler les cyclistes de tous horizons.

> _« Un vélo, c'est bien plus qu'un produit. C'est une solution.  
> Une réponse à un besoin de liberté, de simplicité et de durabilité. »_  
> — _Alexander Anthony_

---

## 🧠 Votre mission

Vous travaillez pour **Local Bike**, qui souhaite développer son **premier tableau de bord** et se lancer dans l’exploitation de ses données.

🎯 **Votre rôle** en tant qu’_Analytics Engineer_ :

> Modéliser les données pour répondre aux besoins de l’entreprise.

---

## 🗄️ Schéma brut : Local Bike

### GCP Project

- **Project name** : `databird-473015`
- **Bronze model** : `dbt_localbike_bronze`

---

### 1️⃣ Création du Dataset

```sql
CREATE SCHEMA IF NOT EXISTS `databird-473015.dbt_localbike_bronze`
OPTIONS (
  location = "US",
  description = "Local Bike schema: Sales & Production"
);

### 2️⃣ Création des Tables

🛒 Sales
-- Customers
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_customers` (
  customer_id INT64 NOT NULL,
  first_name STRING,
  last_name STRING,
  phone STRING,
  email STRING,
  street STRING,
  city STRING,
  state STRING,
  zip_code STRING,
  CONSTRAINT pk_customers PRIMARY KEY (customer_id) NOT ENFORCED
);

-- Stores
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_stores` (
  store_id INT64 NOT NULL,
  store_name STRING,
  phone STRING,
  email STRING,
  street STRING,
  city STRING,
  state STRING,
  zip_code STRING,
  CONSTRAINT pk_stores PRIMARY KEY (store_id) NOT ENFORCED
);

-- Staffs
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_staffs` (
  staff_id INT64 NOT NULL,
  first_name STRING,
  last_name STRING,
  email STRING,
  phone STRING,
  active BOOL,
  store_id INT64,
  manager_id INT64,
  CONSTRAINT pk_staffs PRIMARY KEY (staff_id) NOT ENFORCED,
  CONSTRAINT fk_staffs_store
    FOREIGN KEY (store_id) REFERENCES `databird-473015.dbt_localbike_bronze.stores` (store_id) NOT ENFORCED,
  CONSTRAINT fk_staffs_manager
    FOREIGN KEY (manager_id) REFERENCES `databird-473015.dbt_localbike_bronze.staffs` (staff_id) NOT ENFORCED
);

-- Orders
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_orders` (
  order_id INT64 NOT NULL,
  customer_id INT64,
  order_status STRING,
  order_date DATE,
  required_date DATE,
  shipped_date DATE,
  store_id INT64,
  staff_id INT64,
  CONSTRAINT pk_orders PRIMARY KEY (order_id) NOT ENFORCED,
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES `databird-473015.dbt_localbike_bronze.customers` (customer_id) NOT ENFORCED,
  CONSTRAINT fk_orders_store
    FOREIGN KEY (store_id) REFERENCES `databird-473015.dbt_localbike_bronze.stores` (store_id) NOT ENFORCED,
  CONSTRAINT fk_orders_staff
    FOREIGN KEY (staff_id) REFERENCES `databird-473015.dbt_localbike_bronze.staffs` (staff_id) NOT ENFORCED
);

-- Order Items
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_order_items` (
  order_id INT64 NOT NULL,
  item_id INT64 NOT NULL,
  product_id INT64,
  quantity INT64,
  list_price NUMERIC,
  discount NUMERIC, -- 0–1 si remise en ratio
  CONSTRAINT pk_order_items PRIMARY KEY (order_id, item_id) NOT ENFORCED
);


🏭 Production

-- Brand
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_brands` (
  brand_id INT64 NOT NULL,
  brand_name STRING,
  CONSTRAINT pk_brands PRIMARY KEY (brand_id) NOT ENFORCED
);

-- Categories
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_categories` (
  category_id INT64 NOT NULL,
  category_name STRING,
  CONSTRAINT pk_categories PRIMARY KEY (category_id) NOT ENFORCED
);

-- Products
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_products` (
  product_id INT64 NOT NULL,
  product_name STRING,
  brand_id INT64,
  category_id INT64,
  model_year INT64,
  list_price NUMERIC,
  CONSTRAINT pk_products PRIMARY KEY (product_id) NOT ENFORCED,
  CONSTRAINT fk_products_brand
    FOREIGN KEY (brand_id) REFERENCES `databird-473015.dbt_localbike_bronze.brands` (brand_id) NOT ENFORCED,
  CONSTRAINT fk_products_category
    FOREIGN KEY (category_id) REFERENCES `databird-473015.dbt_localbike_bronze.categories` (category_id) NOT ENFORCED
);

-- Stocks
CREATE TABLE IF NOT EXISTS `databird-473015.dbt_localbike_bronze.stg_src_local_bike_stocks` (
  store_id INT64 NOT NULL,
  product_id INT64 NOT NULL,
  quantity INT64,
  CONSTRAINT pk_stocks PRIMARY KEY (store_id, product_id) NOT ENFORCED,
  CONSTRAINT fk_stocks_store
    FOREIGN KEY (store_id) REFERENCES `databird-473015.dbt_localbike_bronze.stg_src_local_bike_stores` (store_id) NOT ENFORCED,
  CONSTRAINT fk_stocks_product
    FOREIGN KEY (product_id) REFERENCES `databird-473015.dbt_localbike_bronze.stg_src_local_bike_products` (product_id) NOT ENFORCED
);

-- FK
ALTER TABLE `databird-473015.dbt_localbike_bronze.stg_src_local_bike_order_items`
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id) REFERENCES `databird-473015.dbt_localbike_bronze.stg_src_local_bike_orders` (order_id) NOT ENFORCED;

ALTER TABLE `databird-473015.dbt_localbike_bronze.stg_src_local_bike_order_items`
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id) REFERENCES `databird-473015.dbt_localbike_bronze.stg_src_local_bike_products` (product_id) NOT ENFORCED;


🧩 Diagramme Relationnel (ER Diagram)
erDiagram
  %% =========================
  %%        SALES
  %% =========================
  CUSTOMERS {
    INT64  customer_id PK
    STRING first_name
    STRING last_name
    STRING phone
    STRING email
    STRING street
    STRING city
    STRING state
    STRING zip_code
  }

  STORES {
    INT64  store_id PK
    STRING store_name
    STRING phone
    STRING email
    STRING street
    STRING city
    STRING state
    STRING zip_code
  }

  STAFFS {
    INT64  staff_id PK
    STRING first_name
    STRING last_name
    STRING email
    STRING phone
    BOOL   active
    INT64  store_id FK
    INT64  manager_id FK
  }

  ORDERS {
    INT64  order_id PK
    INT64  customer_id FK
    STRING order_status
    DATE   order_date
    DATE   required_date
    DATE   shipped_date
    INT64  store_id FK
    INT64  staff_id FK
  }

  ORDER_ITEMS {
    INT64  order_id  PK, FK
    INT64  item_id   PK
    INT64  product_id FK
    INT64  quantity
    NUMERIC list_price
    NUMERIC discount
  }

  %% =========================
  %%      PRODUCTION
  %% =========================
  BRANDS {
    INT64  brand_id PK
    STRING brand_name
  }

  CATEGORIES {
    INT64  category_id PK
    STRING category_name
  }

  PRODUCTS {
    INT64  product_id PK
    STRING product_name
    INT64  brand_id FK
    INT64  category_id FK
    INT64  model_year
    NUMERIC list_price
  }

  STOCKS {
    INT64  store_id   PK, FK
    INT64  product_id PK, FK
    INT64  quantity
  }

  %% =========================
  %%      RELATIONSHIPS
  %% =========================
  CUSTOMERS ||--o{ ORDERS : "places"
  STORES    ||--o{ ORDERS : "receives"
  STAFFS    ||--o{ ORDERS : "handles"
  STAFFS    ||--o{ STAFFS : "manages"

  ORDERS    ||--o{ ORDER_ITEMS : "contains"
  PRODUCTS  ||--o{ ORDER_ITEMS : "listed in"

  BRANDS     ||--o{ PRODUCTS : "has"
  CATEGORIES ||--o{ PRODUCTS : "has"

  STORES   ||--o{ STOCKS : "stocks"
  PRODUCTS ||--o{ STOCKS : "stocked as"


## 🏗️ Project Structure (Medallion Architecture)

local_bike/
│
├── dbt_project.yml
|
├── analyses/
│
├── docs/
│ ├── int_src_local_bike_product_daily.md
│ ├── int_src_local_bike_staff_daily.md
│ ├── int_src_local_bike_staff_hierarchy.md
│ ├── int_src_local_bike_store_daily.md
│ ├── int_src_local_bike_store_shipped_order.md
│ ├── mrt_order_shipped_aborted_montly.md
│ ├── mrt_order_shipped_montly.md
│ ├── mrt_products_brands_monthly.md
│ ├── mrt_products_ranking_yearly_top3.md
│ ├── mrt_sales_seasons_yearly.md
│ ├── mrt_staff_ranking_yearly.md
│ ├── mrt_staff_sales_monthly.md
│ ├── mrt_stores_items_monthly.md
│ ├── mrt_stores_ranking_yearly.md
│ └── mrt_stores_sales_monthly.md
|
├── models/
│ ├── bronze/ # staging sources, data from BigQuery
│ │ ├── schema.yml
│ │ ├── stg_src_local_bike_brands.sql
│ │ ├── stg_src_local_bike_categories.sql
│ │ ├── stg_src_local_bike_customers.sql
│ │ ├── stg_src_local_bike_orders.sql
│ │ ├── stg_src_local_bike_order_items.sql
│ │ ├── stg_src_local_bike_products.sql
│ │ ├── stg_src_local_bike_staffs.sql
│ │ ├── stg_src_local_bike_stocks.sql
│ │ └── stg_src_local_bike_stores.sql
│ │
│ ├── silver/ # Intermediate models
│ │ ├──int_src_local_bike_product_daily.sql
│ │ ├──int_src_local_bike_staff_daily.sql
│ │ ├──int_src_local_bike_staff_hierarchy.sql
│ │ ├──int_src_local_bike_store_daily.sql
│ │ ├──int_src_local_bike_store_shipped_order.sql
│ │ ├──_int_src_local_bike_product_daily.yml
│ │ ├──_int_src_local_bike_staff_daily.yml
│ │ ├──_int_src_local_bike_staff_hierarchy.yml
│ │ ├──_int_src_local_bike_store_daily.yml
│ │ └──_int_src_local_bike_store_shipped_order.yml
│ │
│ ├── gold/ # Analytical models for BI tools
│ │ ├──mrt_order_shipped_aborted_montly.sql
│ │ ├──mrt_order_shipped_montly.sql
│ │ ├──mrt_products_brands_monthly.sql
│ │ ├──mrt_products_ranking_yearly_top3.sql
│ │ ├──mrt_sales_seasons_yearly.sql
│ │ ├──mrt_staff_ranking_yearly.sql
│ │ ├──mrt_staff_sales_monthly.sql
│ │ ├──mrt_stores_items_monthly.sql
│ │ ├──mrt_stores_ranking_yearly.sql
│ │ ├──mrt_stores_sales_monthly.sql
│ │ ├──_mrt_order_shipped_aborted_montly.yml
│ │ ├──_mrt_order_shipped_montly.yml
│ │ ├──_mrt_products_brands_monthly.yml
│ │ ├──_mrt_products_ranking_yearly_top3.yml
│ │ ├──_mrt_sales_seasons_yearly.yml
│ │ ├──_mrt_staff_ranking_yearly.yml
│ │ ├──_mrt_staff_sales_monthly.yml
│ │ ├──_mrt_stores_items_monthly.yml
│ │ ├──_mrt_stores_ranking_yearly.yml
│ │ └──_mrt_stores_sales_monthly.yml
│ │
│ └── sources.yml
|
├── macros/
│ ├── calculate_total_order_item_amount.sql
│ ├── cents_to_dollars.sql
│ ├── get_season.sql
│ └── list_months.sql
│
├── tests/
│ ├── assert_total_order_amount_is_positive.sql
|
└── seeds/
│ └── map.csv
| └── seasons.csv
|
└── snapshots/
|
└── README.md
└── package-lock.yml
└── packages.yml
└── README.md
```
