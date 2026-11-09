# Learning Management System (LMS)

**A comprehensive open-source platform for online education, course administration, and digital learning.**

[![Build Status](https://img.shields.io/badge/Build-Project-blue)]()
[![PHP](https://img.shields.io/badge/PHP-8.2%20%7C%208.3-777BB4?logo=php&logoColor=white)](https://www.php.net/)
[![Database](https://img.shields.io/badge/Database-MariaDB%20%7C%20MySQL-blue)]()
[![License](https://img.shields.io/badge/License-GPL--3.0%2B-green)](https://www.gnu.org/licenses/gpl-3.0.html)

---

## Overview

The Learning Management System (LMS) is a web-based educational platform designed to simplify the administration, delivery, and management of online learning activities.

The platform provides an integrated environment for administrators, instructors, and students to manage educational resources, organize courses, conduct assessments, monitor academic progress, and collaborate through digital learning tools.

Built on the open-source Chamilo LMS platform, it provides a flexible learning environment suitable for educational institutions, training organizations, and online education providers.

The system combines course management, student administration, assessment tools, communication services, and learning analytics within a centralized platform.

## Features

The platform provides a comprehensive set of educational and administrative features, including:

- **Announcements** – Publish course announcements and important academic notifications.
- **API Integration** – Connect with external systems such as HR, SIS, ERP, and e-commerce platforms.
- **Assignments** – Create assignments, manage submissions, evaluate work, and support collaborative grading.
- **Attendance Management** – Record attendance, monitor participation, and generate attendance reports.
- **Calendar Management** – Organize academic events, reminders, and scheduled activities.
- **Content Management** – Create and manage educational pages, menus, and learning resources.
- **Course Administration** – Create, edit, publish, import, export, and manage courses.
- **Course Catalogue** – Organize courses and provide course discovery and filtering.
- **Document Management** – Upload, download, share, and collaborate on educational documents.
- **Multimedia Learning** – Support video, audio, images, and interactive learning materials.
- **Discussion Forums** – Enable communication, discussions, peer reviews, and collaboration.
- **Learning Paths** – Create and manage structured learning sequences.
- **Live Chat** – Support communication between students and instructors.
- **Gradebook** – Manage student grades, generate certificates, and issue achievement badges.
- **Learning Analytics** – Monitor student progress, course completion, participation, and assessment performance.
- **Group Management** – Organize students into groups and classes.
- **Multilingual Support** – Provide multilingual interfaces with right-to-left language support.
- **Online Quizzes** – Create assessments with multiple question types, time limits, and randomized questions.
- **Role Management** – Configure user roles and access permissions.
- **Session Management** – Organize courses and recurring learning sessions.
- **Skills Management** – Define skills, assign competencies, and track learning achievements.
- **Student Profiles** – Manage personal information, account settings, and notifications.
- **Customization** – Customize the interface, colors, stylesheets, and platform branding.
- **Surveys** – Create surveys, collect responses, and analyze results.
- **Security** – Support authentication policies, two-factor authentication, and security configurations.
- **Standards Compliance** – Support SCORM 1.2, QTI, LTI, xAPI CMI5, and Aiken formats.
- **Video Conferencing** – Integrate external conferencing and real-time collaboration services.

**Note:** AI-powered functionality and certain external integrations require access to compatible third-party services and may require separate subscriptions.

## Installation

### System Requirements

Before installing the application, ensure that the server meets the following minimum requirements.

**Server Requirements**

| Component | Requirement |
|---|---|
| Processor | 2 vCPUs |
| RAM | 4 GB recommended |
| Storage | 4 GB available disk space |
| Operating System | Ubuntu Server 24.04 LTS or later |
| Web Server | Apache |
| PHP | PHP 8.2 or 8.3 |
| Database | MariaDB 10+ or MySQL 5.7+ |

**Client Requirements**

- A modern desktop or laptop computer.
- An updated web browser.
- A stable internet connection.
- JavaScript-enabled browser support.

### Software Dependencies

The application requires the following software components:

- PHP and the required PHP extensions.
- Apache HTTP Server.
- MariaDB or MySQL database server.
- PHP database connectivity.
- Composer and other development dependencies when installing from source.

### Installation on Ubuntu

The following instructions describe a reference installation of Chamilo 2.0 on an Ubuntu server.

**1. Update the System**

```bash
sudo apt update && sudo apt -y upgrade
```

**2. Install Required Packages**

```bash
sudo apt install -y apache2 libapache2-mod-php \
mariadb-client mariadb-server \
php-{apcu,bcmath,cli,curl,dev,gd,intl,ldap,mbstring,mysql,redis,soap,xml,zip} \
unzip curl
```

**3. Configure the Database**

Create the application database and configure a dedicated database user with the necessary permissions.

Use secure database credentials instead of example passwords.

**4. Download the Application**

For the documented Chamilo 2.0 release candidate:

```bash
cd /var/www

sudo wget https://github.com/chamilo/chamilo-lms/releases/download/v2.0.0-RC.1/chamilo-2.0.0-RC.1.tar.gz

sudo tar zxf chamilo-2.0.0-RC.1.tar.gz

sudo mv chamilo-2.0.0-RC.1 chamilo
```

**5. Configure Apache**

```bash
cd /var/www/chamilo

sudo cp public/main/install/apache.dist.conf \
/etc/apache2/sites-available/lms.conf
```

Configure the virtual host according to your domain and server environment.

Enable the required Apache modules:

```bash
sudo a2ensite lms.conf

sudo a2enmod rewrite ssl headers expires
```

**6. Configure Permissions**

```bash
sudo chown -R www-data: .env config/ var/

sudo systemctl restart apache2
```

**7. Complete the Installation**

Open the configured domain in your browser:

```text
https://your-domain.com
```

Follow the installation wizard to configure the database connection, administrator account, and application settings.

After installation, restore secure ownership and permissions for sensitive configuration files.

**Important:** Chamilo 2.0.0-RC.1 is a release-candidate version. The original project documentation recommends Chamilo 1.11.x for stable installations. Verify the currently supported release before production deployment.

For shared or free hosting environments, refer to `PROFREE_HOSTING.md`.

## Configuration

Most application settings can be managed through the administration interface.

The primary configuration files include:

| File / Directory | Purpose |
|---|---|
| `.env` | Environment variables and database configuration. |
| `config/` | Application and framework configuration. |
| `config/packages/` | Symfony package configuration. |
| `var/` | Application runtime data and cache. |
| `public/` | Public web application directory. |

For advanced configuration, it is recommended to place environment-specific overrides in `config/packages/prod/` rather than directly modifying the default configuration files.

This approach improves maintainability and reduces configuration conflicts during application upgrades.

## Usage

Once installation is complete, administrators, instructors, and students can access the platform through their respective accounts.

The platform provides dedicated functionality for:

- **Administrators:** Manage users, courses, permissions, system settings, and platform configuration.
- **Instructors:** Create courses, upload learning materials, manage assignments, conduct assessments, and evaluate students.
- **Students:** Access courses, study learning materials, submit assignments, participate in discussions, and monitor academic progress.

## API Integration

The platform supports API integration for communication with external applications and services.

JWT authentication can be used to secure API requests.

**Generate JWT Keys**

```bash
php bin/console lexik:jwt:generate-keypair
```

**Configure Apache Authorization Headers**

```apache
SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
```

**Generate an Authentication Token**

```bash
curl -X POST https://your-domain.com/api/authentication_token \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"your-password"}'
```

The authentication endpoint returns a JWT token that can be used to authorize subsequent API requests.

**API Documentation**

After configuring the application, access:

```text
https://your-domain.com/api
```

Use the Authorize option to provide the generated bearer token.

## Documentation

Additional technical documentation and resources are available through the following links:

- [Chamilo Official Documentation](https://docs.chamilo.org/)
- [Chamilo 2.0 Documentation](https://2.chamilo.org/documentation/index.html)
- [PHP Documentation](https://www.php.net/docs.php)
- [MariaDB Documentation](https://mariadb.org/documentation/)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## Contributing

Contributions, improvements, and technical suggestions are welcome.

To contribute:

1. Fork the repository.
2. Create a dedicated feature branch.
3. Implement your changes.
4. Test the implementation.
5. Commit your changes with a descriptive message.
6. Submit a pull request.

For additional development guidelines, refer to `CONTRIBUTING.md`.

## License
There should be no licensing for this project.

## Acknowledgements

This project builds upon the  LMS open-source platform and its development ecosystem.

We acknowledge the contributions of the original developers and open-source contributors who maintain and improve the underlying learning management technology.

---

**Learning Management System — Empowering Digital Education Through Technology.**
