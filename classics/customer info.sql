SELECT
    DISTINCT organizations.id as "organization_id",
    organization_profiles.name as "org_profile_name",
    organizations.stripe_customer_id as "org_stripe_id",
    organizations.created_at as "org_created_at",
    organizations.updated_at as "org_updated_at",
    organization_profiles.billing_contact_email as "org_profile_billing_email",
    projects.id as "project_id",
    projects.name as "project_name",
    projects.created_at as "project_created_at",
    projects.updated_at as "project_updated_at",
    projects.environment_type as "projects_environment_type",
    projects.slug as "project_slug"
FROM
    organizations
    LEFT JOIN organization_profiles on organization_profiles.organization_id = organizations.id
    LEFT JOIN projects on projects.organization_id = organizations.id
/*WHERE
    organizations.id = (6988)*/