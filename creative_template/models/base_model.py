from typing import Optional
from pydantic_yaml import YamlModel


class DateRange(YamlModel):
    start: str
    end: str


class ContactInfo(YamlModel):
    first_name: str
    last_name: str
    phone: str
    email: str
    website: Optional[str]
    linkedin: Optional[str]
    github: Optional[str]

    @property
    def email_user(self):
        return self.email.split("@")[0]

    @property
    def email_domain(self):
        return self.email.split("@")[1]

    @property
    def github_short(self):
        return self.github.replace("https://", "").replace("http://", "")

    @property
    def linkedin_short(self):
        return self.linkedin.replace("https://", "").replace("http://", "")
