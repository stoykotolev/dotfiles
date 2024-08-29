function dev
    # Ensure at least one argument is provided
    if test (count $argv) -eq 1
        set dev_command $argv[1]
    end


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

    # Run the development command based on the package manager
    switch $package_manager
        case "yarn"
            yarn dev 
        case "pnpm"
            pnpm dev
        case "npm"
            npm run dev
    end
end
