-- =============================================
-- DOMAIN: USERS AND STUDENTS
-- =============================================

-- TABLE: users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email ~* '^[a-z0-9](?:[a-z0-9._%+-]{0,62}[a-z0-9])?@(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,24}$'),
    phone VARCHAR(30) CHECK (phone IS NULL OR regexp_replace(phone, '\D', '', 'g') ~ '^[0-9]{10,15}$'),
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    email_verified BOOLEAN DEFAULT false,
    email_verification_token VARCHAR(255) UNIQUE,
    email_verification_expires_at TIMESTAMPTZ,
    password_reset_token VARCHAR(255) UNIQUE,
    password_reset_expires_at TIMESTAMPTZ,
    two_factor_enabled BOOLEAN DEFAULT false,
    two_factor_method VARCHAR(20) DEFAULT 'EMAIL' CHECK (two_factor_method = 'EMAIL'),
    two_factor_code VARCHAR(10),
    two_factor_token VARCHAR(255) UNIQUE,
    two_factor_expires_at TIMESTAMPTZ,
    terms_accepted BOOLEAN DEFAULT false,
    terms_accepted_at TIMESTAMPTZ,
    terms_version VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID
);


-- TABLE: students
CREATE TABLE students (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    school_grade school_grade_enum,
    birth_date DATE,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID
);

-- TABLE: student_guardians
-- Additional users authorized to view/track a student.
CREATE TABLE student_guardians (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL,
    user_id UUID NOT NULL,
    relationship_role VARCHAR(30) NOT NULL DEFAULT 'VIEWER' CHECK (relationship_role IN ('OWNER', 'GUARDIAN', 'VIEWER')),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('PENDING', 'ACTIVE', 'REVOKED')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    UNIQUE (student_id, user_id)
);


-- TABLE: emergency_contacts
CREATE TABLE emergency_contacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    relationship VARCHAR(50),
    is_primary BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID
);
