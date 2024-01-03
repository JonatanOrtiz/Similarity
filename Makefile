generate: ## Generate projects, workspace and install pods | Usage `make generate close=no open=no`
	@./Scripts/killXcode.sh $(close)
	@$(MAKE) pregenerate
	@$(MAKE) generateprojects
	@$(MAKE) installpods
	@$(MAKE) postgenerate

pregenerate:
	@./Scripts/preGenerate.sh

postgenerate:
	@./Scripts/postGenerate.sh $(open)

generateprojects: ## Generate only .xcodeproj projects using Xcodegen
	@./Scripts/killXcode.sh $(close)
	@$(MAKE) generatesources
	@. ./Scripts/asyncGenerateProjects.sh;

generatesources: ## Generate source files with Swiftgen and Sourcery
	@./Scripts/generateResources.sh

installpods: ## Install Cocoapods dependencies and generate workspace based on modules categories
	@echo "\nInstalling Pods"
	@pod install
	@bash ./Scripts/generateWorkspaceData.sh

imports: ## Automatic configure project files with imports
	@./Scripts/Imports.sh