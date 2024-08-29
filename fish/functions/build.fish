function build
    # Function to detect the package manager
    function detect_package_manager
        if test -f yarn.lock
            echo "yarn"
        else if test -f pnpm-lock.yaml
            echo "pnpm"
        else
            echo "npm"
        end
    end

    # Detect the package manager
    set package_manager (detect_package_manager)

    # Run the build command based on the package manager
    switch $package_manager
        case "yarn"
            yarn build
        case "pnpm"
            pnpm build
        case "npm"
            npm run build
    end
end
