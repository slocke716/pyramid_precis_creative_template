"""Top-level package for Pyramid Resume Template Default."""

__version__ = "0.1.0"


def includeme(config):
    config.include("pyramid_jinja2")
    config.add_jinja2_extension("jinja2.ext.with_")
    config.add_jinja2_search_path("creative_template:templates")
    config.add_static_view("creative_template", "creative_template:static/")
