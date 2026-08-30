USE gym_website;

UPDATE membership_plans SET price = 499.00 WHERE plan_name = 'Basic';
UPDATE membership_plans SET price = 999.00 WHERE plan_name = 'Standard';
UPDATE membership_plans SET price = 1999.00 WHERE plan_name = 'Premium';

-- Also update any existing user memberships to have more realistic dates if needed,
-- but the main task is the price currency display and success message.

-- Let's check the current plans
SELECT * FROM membership_plans;
