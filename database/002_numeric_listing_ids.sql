ALTER TABLE enquiries DROP CONSTRAINT IF EXISTS enquiries_listing_id_fkey;
ALTER TABLE enquiries DROP CONSTRAINT IF EXISTS enquiries_offered_listing_id_fkey;
ALTER TABLE enquiries DROP CONSTRAINT IF EXISTS fk_enquiries_listing_listings;
ALTER TABLE enquiries DROP CONSTRAINT IF EXISTS fk_enquiries_offered_listing_listings;

ALTER TABLE listings ADD COLUMN IF NOT EXISTS numeric_id integer;
UPDATE listings SET numeric_id = mapping.numeric_id
FROM (
  VALUES
    ('modern-family-motorhome', 1),
    ('two-year-old-family-motorhome', 2),
    ('near-new-luxury-camper', 3),
    ('classic-coastal-campervan', 4),
    ('compact-weekender-caravan', 5),
    ('heritage-travel-trailer', 6),
    ('bright-ducato-camper', 7),
    ('autosleeper-clubman-escape', 8),
    ('off-road-sprinter-adventure', 9),
    ('citroen-h-van-retreat', 10)
) AS mapping(slug, numeric_id)
WHERE listings.id = mapping.slug;

ALTER TABLE listings ADD COLUMN IF NOT EXISTS slug text;
UPDATE listings SET slug = id WHERE slug IS NULL;

ALTER TABLE enquiries ADD COLUMN IF NOT EXISTS numeric_listing_id integer;
ALTER TABLE enquiries ADD COLUMN IF NOT EXISTS numeric_offered_listing_id integer;

UPDATE enquiries SET numeric_listing_id = listings.numeric_id
FROM listings
WHERE enquiries.listing_id = listings.slug;

UPDATE enquiries SET numeric_offered_listing_id = listings.numeric_id
FROM listings
WHERE enquiries.offered_listing_id = listings.slug;

ALTER TABLE enquiries DROP COLUMN listing_id;
ALTER TABLE enquiries DROP COLUMN offered_listing_id;
ALTER TABLE enquiries RENAME COLUMN numeric_listing_id TO listing_id;
ALTER TABLE enquiries RENAME COLUMN numeric_offered_listing_id TO offered_listing_id;

ALTER TABLE listings DROP CONSTRAINT listings_pkey;
ALTER TABLE listings DROP COLUMN id;
ALTER TABLE listings RENAME COLUMN numeric_id TO id;

ALTER TABLE listings ALTER COLUMN id SET NOT NULL;
ALTER TABLE listings ALTER COLUMN slug SET NOT NULL;
ALTER TABLE enquiries ALTER COLUMN listing_id SET NOT NULL;

ALTER TABLE listings ADD PRIMARY KEY (id);
ALTER TABLE listings ADD CONSTRAINT listings_slug_key UNIQUE (slug);
ALTER TABLE enquiries ADD CONSTRAINT enquiries_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE RESTRICT;
ALTER TABLE enquiries ADD CONSTRAINT enquiries_offered_listing_id_fkey FOREIGN KEY (offered_listing_id) REFERENCES listings(id) ON DELETE RESTRICT;

CREATE SEQUENCE IF NOT EXISTS listings_id_seq;
SELECT setval('listings_id_seq', COALESCE((SELECT MAX(id) FROM listings), 0) + 1, false);
ALTER TABLE listings ALTER COLUMN id SET DEFAULT nextval('listings_id_seq');
ALTER SEQUENCE listings_id_seq OWNED BY listings.id;

CREATE INDEX IF NOT EXISTS listings_slug_idx ON listings(slug);
CREATE INDEX IF NOT EXISTS enquiries_listing_id_idx ON enquiries(listing_id);
