export const config = { runtime: 'edge' };

const SUPABASE_URL = 'https://zswxjecwcqgypcfktpdq.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpzd3hqZWN3Y3FneXBjZmt0cGRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODMxMjQyMDEsImV4cCI6MjA5ODcwMDIwMX0.qWM983SCiQVX2GeDYTQNoEWCNmgox8v4fOlB0Djnotg';

export default async function handler(req) {
  const res = await fetch(
    `${SUPABASE_URL}/rest/v1/locations?select=name,address,latitude,longitude&order=name`,
    {
      headers: {
        apikey: SUPABASE_KEY,
        Authorization: `Bearer ${SUPABASE_KEY}`,
      },
    }
  );

  const data = await res.json();

  return new Response(JSON.stringify(data), {
    headers: {
      'Content-Type': 'application/json',
      'Cache-Control': 's-maxage=3600',
      'Access-Control-Allow-Origin': 'https://getsofra.com',
    },
  });
}
