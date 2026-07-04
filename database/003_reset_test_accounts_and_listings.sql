BEGIN;

ALTER TABLE listings DROP CONSTRAINT IF EXISTS fk_listings_owner_users;
ALTER TABLE listings DROP CONSTRAINT IF EXISTS listings_owner_id_fkey;

TRUNCATE TABLE enquiries RESTART IDENTITY;
DELETE FROM users;

INSERT INTO users (
  id,
  username,
  email,
  password_hash,
  bio,
  location,
  member_since,
  spoken_languages,
  identity_verification_status,
  created_at,
  updated_at
) VALUES
  ('11111111-1111-1111-1111-111111111111', 'test1', 'test1@qq.com', 'pbkdf2-sha256.100000.jUVCm87ISQDV+ECPsCkriA==.OhJXFn60jIi7vcAtxiA1u9dNX5hxiOKNWreXTPA81NA=', 'A Christchurch-based family who enjoy school-holiday road trips, quiet campsites, and practical vehicle swaps with clear planning.', 'Christchurch, New Zealand', '2023-03-14', 'English', 'verified', now(), now()),
  ('22222222-2222-2222-2222-222222222222', 'test2', 'test2@qq.com', 'pbkdf2-sha256.100000.jUVCm87ISQDV+ECPsCkriA==.OhJXFn60jIi7vcAtxiA1u9dNX5hxiOKNWreXTPA81NA=', 'A Wellington couple who like compact campers, coastal routes, and flexible non-simultaneous exchanges around New Zealand and Australia.', 'Wellington, New Zealand', '2022-09-08', 'English, Mandarin', 'verified', now(), now()),
  ('33333333-3333-3333-3333-333333333333', 'test3', 'test3@qq.com', 'pbkdf2-sha256.100000.jUVCm87ISQDV+ECPsCkriA==.OhJXFn60jIi7vcAtxiA1u9dNX5hxiOKNWreXTPA81NA=', 'A Melbourne owner who prefers tidy handovers, long-weekend escapes, and exchanges with members who care for vehicles carefully.', 'Melbourne, Australia', '2024-01-21', 'English', 'verified', now(), now()),
  ('44444444-4444-4444-4444-444444444444', 'test4', 'test4@qq.com', 'pbkdf2-sha256.100000.jUVCm87ISQDV+ECPsCkriA==.OhJXFn60jIi7vcAtxiA1u9dNX5hxiOKNWreXTPA81NA=', 'An Auckland-based traveller interested in scenic drives, reliable communication, and swapping with owners who share detailed trip plans.', 'Auckland, New Zealand', '2021-11-30', 'English, Cantonese', 'verified', now(), now()),
  ('55555555-5555-5555-5555-555555555555', 'test5', 'test5@qq.com', 'pbkdf2-sha256.100000.jUVCm87ISQDV+ECPsCkriA==.OhJXFn60jIi7vcAtxiA1u9dNX5hxiOKNWreXTPA81NA=', 'A Brisbane motorhome enthusiast who enjoys national parks, simple direct exchanges, and helping visitors plan comfortable road trips.', 'Brisbane, Australia', '2023-07-05', 'English', 'verified', now(), now());

INSERT INTO listings (
  id,
  slug,
  owner_id,
  title,
  description,
  category,
  listing_type,
  country,
  city,
  current_location,
  exchange_method,
  exchange_timings,
  exchange_types,
  wanted_assets,
  wanted_destinations,
  available_from,
  available_to,
  image_label,
  image_asset_key,
  status,
  created_at,
  updated_at
) VALUES
  (1, 'modern-family-motorhome', '11111111-1111-1111-1111-111111111111', 'Modern Family Motorhome', 'A bright, easy-driving motorhome set up for family trips and long stays.', 'Vehicles', 'MotorHome/RV', 'New Zealand', 'Christchurch', 'Christchurch, New Zealand', 'Direct Exchange', ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['MotorHome/RV', 'Campervan'], ARRAY['United Kingdom', 'United States', 'Australia'], '2026-06-01', '2026-10-01', 'Modern motorhome', 'listing-01', 'active', '2026-06-15', now()),
  (2, 'two-year-old-family-motorhome', '11111111-1111-1111-1111-111111111111', '2-Year-Old Family Motorhome', 'Recently fitted interior, generous storage, and a comfortable layout for four.', 'Vehicles', 'MotorHome/RV', 'New Zealand', 'Auckland', 'Auckland, New Zealand', 'Direct Exchange', ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['MotorHome/RV'], ARRAY['United States'], '2026-07-15', '2026-12-15', 'Family motorhome', 'listing-02', 'active', '2026-06-12', now()),
  (3, 'near-new-luxury-camper', '22222222-2222-2222-2222-222222222222', 'Near - New Luxury Camper', 'Near-new camper with premium finishes, compact handling, and coastal trip comfort.', 'Vehicles', 'MotorHome/RV', 'New Zealand', 'Wellington', 'Wellington, New Zealand', 'Direct Exchange', ARRAY['Non-simultaneous'], ARRAY['Non-simultaneous'], ARRAY['MotorHome/RV', 'Holiday Home'], ARRAY['Canada', 'Australia'], '2026-05-20', '2026-09-30', 'Luxury camper', 'listing-03', 'active', '2026-06-09', now()),
  (4, 'classic-coastal-campervan', '22222222-2222-2222-2222-222222222222', 'Classic Coastal Campervan', 'A character-filled campervan with a simple, reliable setup for relaxed coastal touring.', 'Vehicles', 'MotorHome/RV', 'New Zealand', 'Hamilton', 'Hamilton, New Zealand', 'Direct Exchange', ARRAY['Simultaneous'], ARRAY['Simultaneous'], ARRAY['MotorHome/RV', 'Campervan'], ARRAY['Canada', 'United Kingdom'], '2026-08-01', '2026-11-30', 'Classic campervan', 'listing-04', 'active', '2026-06-04', now()),
  (5, 'compact-weekender-caravan', '33333333-3333-3333-3333-333333333333', 'Compact Weekender Motorhome', 'A tidy compact motorhome suited to couples who want an easy base for short scenic escapes.', 'Vehicles', 'MotorHome/RV', 'Australia', 'Melbourne', 'Melbourne, Australia', 'Direct Exchange', ARRAY['Non-simultaneous'], ARRAY['Non-simultaneous'], ARRAY['MotorHome/RV'], ARRAY['New Zealand', 'Canada'], '2026-06-10', '2026-08-31', 'Compact motorhome', 'listing-05', 'active', '2026-05-29', now()),
  (6, 'heritage-travel-trailer', '33333333-3333-3333-3333-333333333333', 'Heritage Touring Motorhome', 'A vintage-inspired motorhome for slow road trips, quiet campgrounds, and open landscapes.', 'Vehicles', 'MotorHome/RV', 'Canada', 'Calgary', 'Calgary, Canada', 'Direct Exchange', ARRAY['Simultaneous'], ARRAY['Simultaneous'], ARRAY['MotorHome/RV', 'Home'], ARRAY['Australia', 'New Zealand'], '2026-09-01', '2027-01-15', 'Heritage motorhome', 'listing-06', 'active', '2026-05-23', now()),
  (7, 'bright-ducato-camper', '44444444-4444-4444-4444-444444444444', 'Bright Ducato Camper', 'A practical coachbuilt camper with generous living space and a clean, comfortable cabin.', 'Vehicles', 'MotorHome/RV', 'United Kingdom', 'London', 'London, United Kingdom', 'Direct Exchange', ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['MotorHome/RV', 'Campervan'], ARRAY['United States', 'New Zealand'], '2026-06-20', '2026-10-20', 'Bright Ducato camper', 'listing-07', 'active', '2026-05-18', now()),
  (8, 'autosleeper-clubman-escape', '44444444-4444-4444-4444-444444444444', 'Autosleeper Clubman Escape', 'A compact European campervan that is easy to park, easy to drive, and ready for village stays.', 'Vehicles', 'MotorHome/RV', 'United Kingdom', 'Manchester', 'Manchester, United Kingdom', 'Direct Exchange', ARRAY['Non-simultaneous'], ARRAY['Non-simultaneous'], ARRAY['MotorHome/RV'], ARRAY['Canada', 'Australia'], '2026-04-01', '2026-07-31', 'Autosleeper campervan', 'listing-08', 'active', '2026-05-12', now()),
  (9, 'off-road-sprinter-adventure', '55555555-5555-5555-5555-555555555555', 'Off-Road Sprinter Adventure', 'A rugged Sprinter-based camper for travelers who prefer gravel roads and remote trailheads.', 'Vehicles', 'MotorHome/RV', 'United States', 'San Francisco', 'San Francisco, United States', 'Direct Exchange', ARRAY['Simultaneous'], ARRAY['Simultaneous'], ARRAY['MotorHome/RV', 'Canal Boats'], ARRAY['New Zealand', 'United Kingdom'], '2026-10-01', '2027-02-28', 'Off-road sprinter campervan', 'listing-09', 'active', '2026-05-06', now()),
  (10, 'citroen-h-van-retreat', '55555555-5555-5555-5555-555555555555', 'Citroen H Van Retreat', 'A distinctive classic van conversion with charm, compact facilities, and weekend-trip appeal.', 'Vehicles', 'MotorHome/RV', 'Canada', 'Montreal', 'Montreal, Canada', 'Direct Exchange', ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['Simultaneous', 'Non-simultaneous'], ARRAY['MotorHome/RV', 'Holiday Home'], ARRAY['France', 'United Kingdom', 'Australia'], '2026-07-01', '2026-09-15', 'Citroen H van camper', 'listing-10', 'active', '2026-04-28', now())
ON CONFLICT (id) DO UPDATE SET
  slug = EXCLUDED.slug,
  owner_id = EXCLUDED.owner_id,
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  category = EXCLUDED.category,
  listing_type = EXCLUDED.listing_type,
  country = EXCLUDED.country,
  city = EXCLUDED.city,
  current_location = EXCLUDED.current_location,
  exchange_method = EXCLUDED.exchange_method,
  exchange_timings = EXCLUDED.exchange_timings,
  exchange_types = EXCLUDED.exchange_types,
  wanted_assets = EXCLUDED.wanted_assets,
  wanted_destinations = EXCLUDED.wanted_destinations,
  available_from = EXCLUDED.available_from,
  available_to = EXCLUDED.available_to,
  image_label = EXCLUDED.image_label,
  image_asset_key = EXCLUDED.image_asset_key,
  status = EXCLUDED.status,
  created_at = EXCLUDED.created_at,
  updated_at = now();

ALTER TABLE listings
  ADD CONSTRAINT fk_listings_owner_users
  FOREIGN KEY (owner_id)
  REFERENCES users(id)
  ON DELETE RESTRICT;

SELECT setval(pg_get_serial_sequence('listings', 'id'), COALESCE((SELECT MAX(id) FROM listings), 0) + 1, false);

COMMIT;
