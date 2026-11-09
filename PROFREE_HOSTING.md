# Deploying Chamilo LMS on ProFreeHost

This document explains the minimal changes and configuration needed to run Chamilo on a free PHP host such as [ProFreeHost](https://profreehost.com/).

> The codebase itself does **not require logic changes**. Instead you prepare environment variables, ensure build artifacts are included, and upload the project with the correct structure.

## 1. Prepare the code locally

1. Run `composer install --no-dev --optimize-autoloader` to populate `vendor/`.
2. Compile frontend assets with `npm run build` (or the equivalent yarn/webpack command).
3. Make sure the `public/` directory is ready; its `.htaccess` already contains rewrite rules.
4. Optionally, use the helper script to bundle everything into a ZIP archive suitable for FTP upload:
   ```sh
   ./scripts/package_profree.sh
   ```
   This generates `chamilo-profree.zip` containing the full project tree with
   `vendor/` and built assets, excluding development junk. Unzip on the host and
   move the contents into `public_html` (or upload the extracted files directly).
5. Copy `public/` contents into the host's `public_html` (or equivalent) directory. The rest of the project can reside one level above `public_html` if the host allows; if the host restricts you to a single folder, upload everything and adjust the `public/index.php` paths accordingly.

## 2. Environment configuration

Free hosts cannot run `composer` or modify PHP config. You need a `.env` file in the root:

1. Copy the template `\.env.profree` (provided here) to `.env`.
2. Edit the DATABASE_* values with the credentials supplied by ProFreeHost.
3. Set `APP_ENV=prod` and `APP_DEBUG=0`.
4. Choose an `APP_SECRET` (a long random string) and leave `APP_INSTALLED=0` until after installation.

```dotenv
# .env (example for ProFreeHost)
APP_ENV=prod
APP_DEBUG=0
APP_SECRET=replace_with_a_random_value
APP_INSTALLED=0

DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_NAME=your_database_name
DATABASE_USER=your_database_user
DATABASE_PASSWORD=your_database_password

# you may leave other values commented or copy them from .env.dist
```

> The `.env.profree` file in the repository is non-sensitive and serves as a starting point; never commit real secrets.

## 3. Uploading files and permissions

- Use FTP/SFTP to transfer the entire project tree, including `vendor/` and compiled assets.
- Verify writable permissions on `var/cache`, `var/logs` (or `var` on newer versions), and `web/uploads`/`web/files`.
- If the host does not allow `chmod`, contact support or set them via the control panel.

## 4. Database and installation

1. Create a MySQL database from the control panel.
2. Either import the SQL schema located in `install/` or run the web installer by browsing to your site (e.g. `https://example.profreehost.com`).
3. Follow the installer wizard to create the admin user.
4. After installation, set `APP_INSTALLED=1` in `.env`.

## 5. Cron job

Chamilo requires periodic tasks. In the host control panel, add a cron entry like:

```
php /home/youruser/public_html/bin/console chamilo:cron
```

(adjust the path to your installation root).

## 6. Notes

- ProFreeHost uses `public_html` or `htdocs` as the web root. When uploading, the contents of the `public/` directory should go there.
- Some free hosts limit PHP extensions; ensure `pdo_mysql`, `gd`, `intl`, `mbstring` and `zip` are enabled.
- Keep the `.env` file out of version control. It contains secrets.

See also the main `README.md` for general installation procedures.
