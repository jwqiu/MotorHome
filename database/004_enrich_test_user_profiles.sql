ALTER TABLE users ADD COLUMN IF NOT EXISTS location text;
ALTER TABLE users ADD COLUMN IF NOT EXISTS member_since date;
ALTER TABLE users ADD COLUMN IF NOT EXISTS spoken_languages text;

UPDATE users SET
  bio = 'A Christchurch-based family who enjoy school-holiday road trips, quiet campsites, and practical vehicle swaps with clear planning.',
  location = 'Christchurch, New Zealand',
  member_since = '2023-03-14',
  spoken_languages = 'English',
  updated_at = now()
WHERE email = 'test1@qq.com';

UPDATE users SET
  bio = 'A Wellington couple who like compact campers, coastal routes, and flexible non-simultaneous exchanges around New Zealand and Australia.',
  location = 'Wellington, New Zealand',
  member_since = '2022-09-08',
  spoken_languages = 'English, Mandarin',
  updated_at = now()
WHERE email = 'test2@qq.com';

UPDATE users SET
  bio = 'A Melbourne owner who prefers tidy handovers, long-weekend escapes, and exchanges with members who care for vehicles carefully.',
  location = 'Melbourne, Australia',
  member_since = '2024-01-21',
  spoken_languages = 'English',
  updated_at = now()
WHERE email = 'test3@qq.com';

UPDATE users SET
  bio = 'An Auckland-based traveller interested in scenic drives, reliable communication, and swapping with owners who share detailed trip plans.',
  location = 'Auckland, New Zealand',
  member_since = '2021-11-30',
  spoken_languages = 'English, Cantonese',
  updated_at = now()
WHERE email = 'test4@qq.com';

UPDATE users SET
  bio = 'A Brisbane motorhome enthusiast who enjoys national parks, simple direct exchanges, and helping visitors plan comfortable road trips.',
  location = 'Brisbane, Australia',
  member_since = '2023-07-05',
  spoken_languages = 'English',
  updated_at = now()
WHERE email = 'test5@qq.com';
