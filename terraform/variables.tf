variable "project_name" {
  description = "Name prefix applied to management groups"
  type        = string
  default     = "ahmad-lz"
}

variable "allowed_locations" {
  description = "Regions resources are allowed to be created in"
  type        = list(string)
  default     = ["eastus", "westus", "centralus"]
}
