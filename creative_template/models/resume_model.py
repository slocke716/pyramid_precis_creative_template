from typing import Dict, List, Optional, Union
from pydantic import Field
from pydantic_yaml import YamlModel
from resume.models.base_model import DateRange, ContactInfo


class Position(YamlModel):
    title: str
    employer: str
    date: DateRange
    description: str
    bullets: List[Union[str, Dict[str, str]]] = Field(default_factory=list)


class Education(YamlModel):
    degree_date: str
    degree_name: str
    degree_concentration: str
    institution_name: str


class Resume(YamlModel):
    contact_info: ContactInfo
    executive_summary: str
    qualifications: Union[Dict[str, List[str]], List[Dict]]
    positions: List[Position]
    educations: List[Education]
