CREATE TABLE spots(
  id CHAR (32) NOT NULL,
  PRIMARY KEY(id),
  break_name VARCHAR(64),
  break_region VARCHAR(64),
  vibe VARCHAR(64)
);

INSERT INTO customers ( id, break_name, break_region, vibe ) VALUES ( uuid(), 'Zuma Beach', 'Malibu, CA', 'Friendly, but shallow and powerful' );
INSERT INTO customers ( id, break_name, break_region, vibe ) VALUES ( uuid(), 'Ocean Beach', 'San Francisco, CA', 'Unpredictable' );
