
-- *** The Lost Letter ***

-- *** The Devious Delivery ***

-- *** The Forgotten Gift ***

-- *** The Lost Letter ***
-- 1. Find the address ID for the sender (900 Somerville Avenue)
SELECT id FROM addresses WHERE address = '900 Somerville Avenue';

-- 2. Use the address ID to find the package details and its contents
SELECT * FROM packages WHERE from_address_id = (
    SELECT id FROM addresses WHERE address = '900 Somerville Avenue'
);

-- 3. Trace the package in the scans table to find its final drop-off location
SELECT addresses.address, addresses.type
FROM addresses
JOIN scans ON addresses.id = scans.address_id
WHERE scans.package_id = (
    SELECT id FROM packages WHERE from_address_id = (
        SELECT id FROM addresses WHERE address = '900 Somerville Avenue'
    )
) AND scans.action = 'Drop'
ORDER BY scans.timestamp DESC LIMIT 1;


-- *** The Devious Delivery ***
-- 1. The sender is from out of town and there is no "From" address, so from_address_id is NULL
SELECT * FROM packages WHERE from_address_id IS NULL;

-- 2. Trace the package in the scans table to see where it was dropped off
SELECT addresses.address, addresses.type
FROM addresses
JOIN scans ON addresses.id = scans.address_id
WHERE scans.package_id = (
    SELECT id FROM packages WHERE from_address_id IS NULL
) AND scans.action = 'Drop'
ORDER BY scans.timestamp DESC LIMIT 1;


-- *** The Forgotten Gift ***
-- 1. Find the package sent by the grandparent from 109 Tileston Street
SELECT * FROM packages WHERE from_address_id = (
    SELECT id FROM addresses WHERE address = '109 Tileston Street'
);

-- 2. The package was never delivered. Let's check the scans to see who picked it up last.
-- We will join the drivers table to get the name of the driver who currently has it.
SELECT drivers.name
FROM drivers
JOIN scans ON drivers.id = scans.driver_id
WHERE scans.package_id = (
    SELECT id FROM packages WHERE from_address_id = (
        SELECT id FROM addresses WHERE address = '109 Tileston Street'
    )
)
ORDER BY scans.timestamp DESC LIMIT 1;
