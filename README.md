# SalesRegister API

Aplicación Ruby on Rails para registro de ventas, administración de productos, categorías, compras y clientes, con auditoría, autenticación y procesamiento en segundo plano.

---

## 🚀 Requerimientos previos

Asegúrate de tener instalados:

* **Ruby** 3.2.x
* **Rails** 8.x
* **Bundler** (`gem install bundler`)
* **PostgreSQL** (o la base de datos que uses)
* **Redis** (para Sidekiq y Sidekiq-Cron)
* **Node.js** y **Yarn** (para assets si aplica)

---

## 📥 Instalación

1.  **Clonar el repositorio**

    ```bash
    git clone [https://github.com/usuario/salesregister_api.git](https://github.com/usuario/salesregister_api.git)
    cd salesregister_api
    ```

2.  **Instalar dependencias**

    ```bash
    bundle install
    yarn install --check-files
    ```

3.  **Configurar variables de entorno**

    Copia el archivo de ejemplo:

    ```bash
    cp .env.example .env
    ```

    Edita `.env` con tus credenciales (DB, Redis, correo, etc.).

4.  **Configurar base de datos**

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

---

## ▶️ Ejecución en desarrollo

### Servidor Rails

```bash
rails s
```

# Endpoints

---

## Productos

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/productos` | Listar todos los productos |
| `GET` | `/productos/:id` | Mostrar detalle de producto |
| `POST` | `/productos` | Crear producto |
| `PATCH/PUT` | `/productos/:id` | Actualizar producto |
| `DELETE` | `/productos/:id` | Eliminar producto |

---

## Categorías

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/categorias` | Listar todas las categorías |
| `GET` | `/categorias/:id` | Mostrar detalle de categoría |
| `POST` | `/categorias` | Crear categoría |
| `PATCH/PUT` | `/categorias/:id` | Actualizar categoría |
| `DELETE` | `/categorias/:id` | Eliminar categoría |

---

## Clientes

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/clientes` | Listar clientes |
| `GET` | `/clientes/:id` | Mostrar detalle de cliente |
| `POST` | `/clientes` | Crear cliente |
| `PATCH/PUT` | `/clientes/:id` | Actualizar cliente |
| `DELETE` | `/clientes/:id` | Eliminar cliente |

---

## Compras

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/compras` | Listar compras |
| `GET` | `/compras/:id` | Mostrar detalle de compra |
| `POST` | `/compras` | Registrar compra |
| `PATCH/PUT` | `/compras/:id` | Actualizar compra |
| `DELETE` | `/compras/:id` | Eliminar compra |

# 📊 Endpoints especiales

---

## 1. Productos más comprados por categoría

`GET /reportes/productos_mas_comprados`

**Parámetros opcionales:**

* `categoria_id` (int)

---

## 2. Top 3 productos que más han recaudado por categoría

`GET /reportes/top3_productos_recaudacion`

**Parámetros opcionales:**

* `categoria_id` (int)

---

## 3. Listado de compras filtrado

`GET /reportes/compras_filtradas`

**Parámetros opcionales:**

* `fecha_desde` (YYYY-MM-DD)
* `fecha_hasta` (YYYY-MM-DD)
* `categoria_id` (int)
* `cliente_id` (int)
* `admin_id` (int)

---

## 4. Cantidad de compras por granularidad

`GET /reportes/compras_por_granularidad`

**Parámetros obligatorios:**

* `granularidad` (hora, dia, semana, anio)

**Parámetros opcionales:**

* `fecha_desde` (YYYY-MM-DD)
* `fecha_hasta` (YYYY-MM-DD)
* `categoria_id` (int)
* `cliente_id` (int)
* `admin_id` (int)
