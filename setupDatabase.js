const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL
});

async function setupDatabase() {
  try {
    await client.connect();

    try {
      await client.query('CREATE ROLE windmill_user;');
      console.log('Role windmill_user created successfully.');
    } catch (error) {
      console.error('Error creating role windmill_user:', error);
    }

    try {
      await client.query('GRANT ALL ON ALL TABLES IN SCHEMA public TO windmill_user;');
      console.log('Granted all on all tables to windmill_user.');
    } catch (error) {
      console.error('Error granting tables to windmill_user:', error);
    }

    try {
      await client.query('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO windmill_user;');
      console.log('Granted all privileges on all sequences to windmill_user.');
    } catch (error) {
      console.error('Error granting sequences to windmill_user:', error);
    }

    try {
      await client.query('ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO windmill_user;');
      console.log('Altered default privileges on tables for windmill_user.');
    } catch (error) {
      console.error('Error altering default privileges on tables for windmill_user:', error);
    }

    try {
      await client.query('ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO windmill_user;');
      console.log('Altered default privileges on sequences for windmill_user.');
    } catch (error) {
      console.error('Error altering default privileges on sequences for windmill_user:', error);
    }

    try {
      await client.query('CREATE ROLE windmill_admin;');
      console.log('Role windmill_admin created successfully.');
    } catch (error) {
      console.error('Error creating role windmill_admin:', error);
    }

    try {
      await client.query('GRANT windmill_user TO windmill_admin;');
      console.log('Granted windmill_user to windmill_admin.');
    } catch (error) {
      console.error('Error granting windmill_user to windmill_admin:', error);
    }

  } catch (e) {
    console.error('Error connecting to the database:', e);
  } finally {
    await client.end();
    console.log('Database connection closed.');
  }
}

setupDatabase().catch(e => {
  console.error('Unexpected error during database setup:', e);
  process.exit(1);
}); 