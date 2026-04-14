CREATE DATABASE universe;

-- \c universe

-- 1. GALAXY
CREATE TABLE galaxy (
	galaxy_id INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	type VARCHAR(50) NOT NULL,
	age_billion_yrs NUMERIC(6, 2),
	distance_kly INT NOT NULL,
	star_count_bil INT,
	has_black_hole BOOLEAN DEFAULT FALSE NOT NULL,
	is_observable BOOLEAN DEFAULT TRUE NOT NULL,
	notes TEXT
);

INSERT INTO galaxy (name, type, age_billion_yrs, distance_kly, star_count_bil, has_black_hole, is_observable, notes) VALUES
('Milky Way', 'Spiral', 13.61, 0, 250, TRUE, TRUE, 'Our home galaxy'),
('Andromeda', 'Spiral', 10.01, 2537, 1000, TRUE, TRUE, 'Nearest large galaxy'),
('Triangulum', 'Spiral', 8.50, 2730, 40, FALSE, TRUE, 'Third largest in local group'),
('Whirpool', 'Spiral', 0.40, 23160, 100, TRUE, TRUE, 'Famous for its structure'),
('Small Megellanic', 'Irregular', 6.50, 197, 7, FALSE, TRUE, 'Satellite of Milky Way');

-- 2. STAR
CREATE TABLE star (
	star_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,
	spectral_class VARCHAR(10) NOT NULL,
	mass_solar NUMERIC(10, 3) NOT NULL,
	age_million_yrs INT,
	luminosity_lsun INT,
	is_main_sequence BOOLEAN NOT NULL DEFAULT TRUE,
	has_planets BOOLEAN NOT NULL DEFAULT FALSE,
	notes TEXT
);

INSERT INTO star (name, galaxy_id, spectral_class, mass_solar, age_million_yrs, luminosity_lsun, is_main_sequence, has_planets, notes) VALUES
('Sun', 1, 'G2', 1.000, 4600, 1, TRUE, TRUE, 'Our star'),
('Alpha Centauri A', 1, 'G2', 1.100, 5000, 1, TRUE, FALSE, 'Nearest star system to Sun'),
('Vega', 1, 'A0', 2.135, 455, 40, TRUE, FALSE, 'Used as standard for magnitube'),
('Tau Ceti', 1, 'G8', 0.783, 5800, 1, TRUE, TRUE, 'Possible planetary system'),
('Mirach', 2, 'M0', 3.500, 7000, 2000, FALSE, FALSE, 'Red giant in Andromeda'),
('Al Rischa', 3, 'A2', 2.280, 300, 28, TRUE, FALSE, 'Brightest in Triangulum');

-- 3. PLANET



