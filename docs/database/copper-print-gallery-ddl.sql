-- Create ARTIST table
CREATE TABLE ARTIST (
    id SERIAL PRIMARY KEY,
    keycloak_id VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    default_language VARCHAR(10) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_indexed TIMESTAMP WITH TIME ZONE
);

-- Create ARTIST_PREFERENCE table
CREATE TABLE ARTIST_PREFERENCE (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    preference_key VARCHAR(100) NOT NULL,
    preference_value TEXT,
    FOREIGN KEY (artist_id) REFERENCES ARTIST(id) ON DELETE CASCADE
);

-- Create GALLERY table
CREATE TABLE GALLERY (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_indexed TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (artist_id) REFERENCES ARTIST(id) ON DELETE CASCADE
);

-- Create ARTWORK table
CREATE TABLE ARTWORK (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_indexed TIMESTAMP WITH TIME ZONE
);

-- Create GALLERY_ARTWORK table (junction table for many-to-many relationship)
CREATE TABLE GALLERY_ARTWORK (
    gallery_id INTEGER NOT NULL,
    artwork_id INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (gallery_id, artwork_id),
    FOREIGN KEY (gallery_id) REFERENCES GALLERY(id) ON DELETE CASCADE,
    FOREIGN KEY (artwork_id) REFERENCES ARTWORK(id) ON DELETE CASCADE
);

-- Create IMAGE table
CREATE TABLE IMAGE (
    id SERIAL PRIMARY KEY,
    artwork_id INTEGER NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    storage_bucket VARCHAR(255) NOT NULL,
    storage_path VARCHAR(255) NOT NULL,
    public_url VARCHAR(255),
    width INTEGER,
    height INTEGER,
    format VARCHAR(50),
    file_size INTEGER,
    version VARCHAR(50) NOT NULL,
    parent_version VARCHAR(50),
    status VARCHAR(50) NOT NULL,
    processed_at TIMESTAMP WITH TIME ZONE,
    processing_details TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artwork_id) REFERENCES ARTWORK(id) ON DELETE CASCADE
);

-- Create EXIF_DATA table
CREATE TABLE EXIF_DATA (
    id SERIAL PRIMARY KEY,
    image_id INTEGER NOT NULL,
    key VARCHAR(255) NOT NULL,
    value TEXT,
    FOREIGN KEY (image_id) REFERENCES IMAGE(id) ON DELETE CASCADE
);

-- Create ARTWORK_METADATA table
CREATE TABLE ARTWORK_METADATA (
    id SERIAL PRIMARY KEY,
    artwork_id INTEGER UNIQUE NOT NULL,
    artist_name VARCHAR(255) NOT NULL,
    year_created INTEGER,
    medium VARCHAR(100),
    technique VARCHAR(100),
    dimensions VARCHAR(100),
    edition_info VARCHAR(255),
    style_movement VARCHAR(100),
    plate_material VARCHAR(100),
    paper_type VARCHAR(100),
    ink_type VARCHAR(100),
    printing_press VARCHAR(100),
    location VARCHAR(255),
    availability VARCHAR(50),
    price DECIMAL(10, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artwork_id) REFERENCES ARTWORK(id) ON DELETE CASCADE
);

-- Create TAG table
CREATE TABLE TAG (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create ARTWORK_TAG table (junction table for many-to-many relationship)
CREATE TABLE ARTWORK_TAG (
    artwork_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (artwork_id, tag_id),
    FOREIGN KEY (artwork_id) REFERENCES ARTWORK(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES TAG(id) ON DELETE CASCADE
);

-- Create TRANSLATION table
CREATE TABLE TRANSLATION (
    id SERIAL PRIMARY KEY,
    entity_id INTEGER NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    language_code VARCHAR(10) NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    translated_content TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for improved query performance
CREATE INDEX idx_gallery_artist ON GALLERY(artist_id);
CREATE INDEX idx_gallery_artwork_gallery ON GALLERY_ARTWORK(gallery_id);
CREATE INDEX idx_gallery_artwork_artwork ON GALLERY_ARTWORK(artwork_id);
CREATE INDEX idx_image_artwork ON IMAGE(artwork_id);
CREATE INDEX idx_exif_data_image ON EXIF_DATA(image_id);
CREATE INDEX idx_artwork_metadata_artwork ON ARTWORK_METADATA(artwork_id);
CREATE INDEX idx_translation_entity ON TRANSLATION(entity_id, entity_type);
CREATE INDEX idx_translation_language ON TRANSLATION(language_code);
