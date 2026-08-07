# E-Commerce Web Application (Java)

## Tech Stack
- Java Servlets, JSP
- JDBC, MySQL
- HTML, CSS
- Apache Tomcat, Docker & Docker Compose

## Project Structure
```
Ecommerce/
│
├── src/                # Source code (Servlets, JSP, DAO, Controllers)
├── pom.xml             # Maven build configuration
├── target/             # Compiled output binaries (WAR package)
├── Dockerfile          # Multi-stage Docker build config
├── docker-compose.yml  # Local full-stack container orchestration (App + MySQL)
├── koyeb.yaml          # Cloud deployment manifest
├── database.sql        # MySQL database schema & sample data
└── README.md           # Project documentation
```

## Features
- User Login & Registration
- Product Listing (DB driven)
- Cart Management (Session-based)
- Logout with cache handling

---

## 🌐 Hosting & Deployment Options

### 1. Free Cloud Hosting (Koyeb / Render)
You can host this website online for free using **Koyeb** or **Render** with automatic deployment from your GitHub repo [`sanjay020904/ecommerceweb`](https://github.com/sanjay020904/ecommerceweb):

1. **Database**: Create a free cloud MySQL instance on [Aiven](https://aiven.io/), [Clever Cloud](https://www.clever-cloud.com/), or [Railway](https://railway.app/) and import `database.sql`.
2. **Web App**:
   - Go to [Koyeb Console](https://app.koyeb.com/) or [Render Console](https://render.com/).
   - Click **Create App** / **New Web Service** and connect GitHub repository `sanjay020904/ecommerceweb`.
   - Select **Dockerfile** builder.
   - Set environment variables:
     - `DB_URL`: `jdbc:mysql://<your-cloud-mysql-host>:3306/abc?useSSL=false`
     - `DB_USER`: `<cloud-mysql-username>`
     - `DB_PASS`: `<cloud-mysql-password>`
3. Deploy! Koyeb/Render will build the Docker container and assign a live HTTPS URL (e.g. `https://ecommerceweb.koyeb.app`).

---

### 2. Local Hosting via Docker Compose (App + Database)
Run the complete stack (Tomcat App + MySQL Database) locally with a single command:

```bash
# Start Web App and MySQL DB together
docker-compose up --build
```
Access the application at `http://localhost:8080`.

---

### 3. Local IDE / Tomcat Server Setup
1. Import project in IntelliJ / Eclipse.
2. Configure Tomcat 10+ server.
3. Import `database.sql` into local MySQL server.
4. Build using `mvn clean package` and deploy to Tomcat.

---

## Database Design
- **Users**: Stores user credentials
- **Products**: Stores product details
- **Cart**: Maps users with products (Many-to-Many relationship)

## 📸 Screenshots

![Home](screenshots/home.png)
![Login](screenshots/login.png)
![Register](screenshots/register.png)
![Products](screenshots/product.png)
![Cart](screenshots/cart.png)


