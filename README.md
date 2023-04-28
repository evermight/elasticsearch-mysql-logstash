
1. `cp env.sample .env`
2. Fill out the values in `.env`
3. Fill database with sample values: `mysql <databasename> < schema.sql && mysql <databasename> < data.sql`
4. `~/run.sh` to run log stash an ingest data into elasticsearch
