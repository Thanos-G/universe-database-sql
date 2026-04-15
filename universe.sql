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
CREATE TABLE planet(
	planet_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	star_id INT NOT NULL REFERENCES star(star_id) ON DELETE CASCADE,
	planet_type VARCHAR(50) NOT NULL,
	mass_earths NUMERIC(10,3) NOT NULL,
	orbital_days INT NOT NULL,
	diameter_km INT NOT NULL,
	has_rings BOOLEAN NOT NULL DEFAULT FALSE,
	has_atmosphere BOOLEAN NOT NULL DEFAULT TRUE,
	notes TEXT
);

INSERT INTO planet (name, star_id, planet_type, mass_earths, orbital_days, diameter_km, has_rings, has_atmosphere, notes) VALUES
('Mercury', 1, 'Rocky', 0.055, 88, 4879, FALSE, FALSE, 'Closest to Sun'),
('Venus', 1, 'Rocky', 0.815, 225, 12104, FALSE, TRUE, 'Hottest planet'),
('Earth', 1, 'Rocky', 1.000, 365, 12756, FALSE, TRUE, 'Our home'),
('Mars', 1, 'Rocky', 0.107, 687, 6792, FALSE, TRUE, 'The Red planet'),
('Jupiter', 1, 'Gas Giant', 317.800, 4333, 142984, TRUE, TRUE, 'Largest Planet'),
('Saturn', 1, 'Gas Giant', 95.160, 10759, 120536, TRUE, TRUE, 'Famous ring system'),
('Uranus', 1, 'Ice Giant', 14.530, 30687, 51118, TRUE, TRUE, 'Rotates on its side'),
('Neptune', 1, 'Ice Giant', 17.150, 60190, 49528, TRUE, TRUE, 'Windiest planet'),
('Proxima b', 6, 'Rocky', 1.270, 11, 13000, FALSE, TRUE, 'In habitable zone'),
('Tau Ceti e', 7, 'Rocky', 3.930, 168, 18000, FALSE, TRUE, 'Potentially habitable'),
('Proxima c', 6, 'Rocky', 7.000, 1928, 20000, FALSE, FALSE, 'Super-Earth canditate');

-- 4. MOON
CREATE TABLE moon (
	moon_id INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	planet_id INT NOT NULL,
	diameter_km INT NOT NULL,
	orbital_days INT NOT NULL,
	mass_kg NUMERIC(10, 3),
	is_spherical BOOLEAN DEFAULT TRUE NOT NULL,
	has_atmosphere BOOLEAN DEFAULT FALSE NOT NULL,
	notes TEXT
);

INSERT INTO moon (moon_id, name, planet_id, diameter_km, orbital_days, mass_kg, is_spherical, has_atmosphere, notes) VALUES
('Moon', 3, 3475, 27, 734.000, TRUE, FALSE, 'Only natural satellite of Earth'),
('Phobos', 4, 22, 0, 1.066, FALSE, FALSE, 'Closest moon to Mars'),
('Deimos', 4, 12, 1, 0, 0.147, FALSE, FALSE, 'Outermost moon of Mars'),
('Europa', 5, 3122, 4, 480.000, TRUE, TRUE, 'Subsurface ocean possible'),
('Callisto', 5, 4821, 17, 1075.900, TRUE, FALSE, 'Heavily cratered'),
('Amalthea', 5, 167, 0, 2.080, FALSE, FALSE, 'Small inner moon'),
('Titan', 6, 5150, 16, 1345.200, TRUE, TRUE, 'Has thick nitrogen atmosphere'),
('Rea', 6, 1528, 5, 23.065, TRUE, FALSE, 'Second largest of Saturn'),
('Dione', 6, 1123, 3, 10.995, TRUE, FALSE, 'Ice cliffs on surface'),
('Titania', 7, 1578, 9, 35.270, TRUE, FALSE, 'Largest moon of Uranus'),
('Triton', 8, 2707, 6, 214.000, TRUE, TRUE, 'Retrograde orbit, geysers'),
('Proteus', 8, 420, 1, 0.440, FALSE, FALSE, 'Irregular shaped moon');
